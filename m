Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16576325478
	for <lists+linux-arch@lfdr.de>; Thu, 25 Feb 2021 18:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbhBYRUV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Feb 2021 12:20:21 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50724 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhBYRUV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Feb 2021 12:20:21 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6399C9E9D8;
        Thu, 25 Feb 2021 12:19:38 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=23dtnOUfzLyDX+KW1V2mmBc/9V0=; b=H4Brws
        TZSHzddWSKivCGfqVGCqQ88W3DJggqpWSJQLjEH8HQsMhD2So5e5QmQkCPYj8iCy
        iFnpbqKYcjtW7Kdz12+s0V3KoFN+LrWYhWM7Qyc++gTHWp5Rl0StNAGNuyX4GYzr
        LBaQOjTiXI6bMum7/n32YuGBTJP4WakTEyfEk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5C07A9E9D6;
        Thu, 25 Feb 2021 12:19:38 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=n8NygWpegxhLZX877LB3tSwxmKQuyH4sXRAP1vuz7oQ=; b=hh7xvP+hjmn279jUavnDgocmjN/Z3vnhifsJ+CMWWGXDAT6HUHjaX48/Z22fz89en00mXpoHOTRL70JxhT0wCrJT7XPEuQQSs1plC8SJ+ytH0T/AOC8/qLuOkW6UtVssSfvn3qx6jhQndnDdLLjsPHjR8ZrhjxcyY3YEyhRzpDE=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C11A89E9D5;
        Thu, 25 Feb 2021 12:19:37 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id C5C622DA0082;
        Thu, 25 Feb 2021 12:19:36 -0500 (EST)
Date:   Thu, 25 Feb 2021 12:19:36 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Masahiro Yamada <masahiroy@kernel.org>
cc:     linux-kbuild@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 0/4] kbuild: build speed improvment of
 CONFIG_TRIM_UNUSED_KSYMS
In-Reply-To: <20210225160247.2959903-1-masahiroy@kernel.org>
Message-ID: <r3584n3-sq21-qo49-9sp5-r3qp6o611s55@syhkavp.arg>
References: <20210225160247.2959903-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: A343518A-778D-11EB-8355-74DE23BA3BAF-78420484!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 26 Feb 2021, Masahiro Yamada wrote:

> 
> Now CONFIG_TRIM_UNUSED_KSYMS is revived, but Linus is still unhappy
> about the build speed.
> 
> I re-implemented this feature, and the build time cost is now
> almost unnoticeable level.
> 
> I hope this makes Linus happy.

:-)

I'm surprised to see that Linus is using this feature. When disabled 
(the default) this should have had no impact on the build time.

This feature provides a nice security advantage by significantly 
reducing the kernel input surface. And people are using that also to 
better what third party vendor can and cannot do with a distro kernel, 
etc. But that's not the reason why I implemented this feature in the 
first place.

My primary goal was to efficiently reduce the kernel binary size using 
LTO even with kernel modules enabled. Each EXPORT_SYMBOL() created a 
symbol dependency that prevented LTO from optimizing out the related 
code even though a tiny fraction of those exported symbols were needed.

The idea behind the recursion was to catch those cases where disabling 
an exported symbol within a module would optimize out references to more 
exported symbols that, in turn, could be disabled and possibly trigger 
yet more code elimination. There is no way that can be achieved without 
extra compiler passes in a recursive manner.


Nicolas
