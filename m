Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008D4332D5A
	for <lists+linux-arch@lfdr.de>; Tue,  9 Mar 2021 18:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhCIRgS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Mar 2021 12:36:18 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52345 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbhCIRgS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Mar 2021 12:36:18 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EDE84AA116;
        Tue,  9 Mar 2021 12:36:16 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=Q5bTVZkC+LzcSiiWD+vXAhphew4=; b=Q6DrNA
        YYGURgXv6Uca99oe6ghQ1nckzyPBv7KKfjpV95WIn4SI0P/7zhal3p9eKTUudfuw
        U6DuI0KHCQJh+yzMXiC/NnOk4k9u3SEApnI8YeYizcBqw7La/ETU8UOy6reSJ3La
        MMgXyyUO+G9DlMmwqRjTsvDmHm0HxjrV2y/GQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E4892AA115;
        Tue,  9 Mar 2021 12:36:16 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=DdhtRSv6lLEXu3vP9THOvIdQg+N3RK8guLnDMEzAdlA=; b=qGHNc3tCviaiGK1DTsFSW8Jad23GqNat6z+AFXE7Xm0tuDn+nc6igjzClCsrf0Pm+xtu7+LKkKcigufcSTfICY53MJ2uz+oZ4QXugjWgTup4pjDezdE4FHfpsXFUrTGx8i/XKzpDEGGrlVx9bR+a/9oKcpiiBALUHRJqLPpAbtk=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 66A89AA114;
        Tue,  9 Mar 2021 12:36:16 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 856AB2DA017E;
        Tue,  9 Mar 2021 12:36:15 -0500 (EST)
Date:   Tue, 9 Mar 2021 12:36:15 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Masahiro Yamada <masahiroy@kernel.org>
cc:     linux-kbuild@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 3/4] kbuild: re-implement CONFIG_TRIM_UNUSED_KSYMS to
 make it work in one-pass
In-Reply-To: <20210309151737.345722-4-masahiroy@kernel.org>
Message-ID: <354sr3np-67o8-oss9-813s-p2qoro06p4o@syhkavp.arg>
References: <20210309151737.345722-1-masahiroy@kernel.org> <20210309151737.345722-4-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: F372C0B8-80FD-11EB-B49F-D152C8D8090B-78420484!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 10 Mar 2021, Masahiro Yamada wrote:

> Commit a555bdd0c58c ("Kbuild: enable TRIM_UNUSED_KSYMS again, with some
> guarding") re-enabled this feature, but Linus is still unhappy about
> the build time.
> 
> The reason of the slowness is the recursion - this basically works in
> two loops.
> 
> In the first loop, Kbuild builds the entire tree based on the temporary
> autoksyms.h, which contains macro defines to control whether their
> corresponding EXPORT_SYMBOL() is enabled or not, and also gathers all
> symbols required by modules. After the tree traverse, Kbuild updates
> autoksyms.h and triggers the second loop to rebuild source files whose
> EXPORT_SYMBOL() needs flipping.
> 
> This commit re-implements CONFIG_TRIM_UNUSED_KSYMS to make it work in
> one pass. In the new design, unneeded EXPORT_SYMBOL() instances are
> trimmed by the linker instead of the preprocessor.
> 
> After the tree traverse, a linker script snippet <generated/keep-ksyms.h>
> is generated. It feeds the list of necessary sections to vmlinus.lds.S
> and modules.lds.S. The other sections fall into /DISCARD/.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

I'm not sure I do understand every detail here, especially since it is 
so far away from the version that I originally contributed. But the 
concept looks good.

I still think that there is no way around a recursive approach to get 
the maximum effect with LTO, but given that true LTO still isn't applied 
to mainline after all those years, the recursive approach brings 
nothing. Maybe that could be revisited if true LTO ever makes it into 
mainline, and the desire to reduce the binary size is still relevant 
enough to justify it.

Acked-by: Nicolas Pitre <nico@fluxnic.net>


Nicolas
