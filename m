Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D708C1651DC
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 22:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgBSVqr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 16:46:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:47890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbgBSVqr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 16:46:47 -0500
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7624424654;
        Wed, 19 Feb 2020 21:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582148806;
        bh=HxfYRjJj58z+qAAsFwPuZfJ0KZbNY+dKSV+60i8qVIs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Muu7wuj9ri3Wvcl3mc3d8sk4smKoASDoa02eUn9plYSjI6agD+f8aGFYssTJjKK05
         dExvMbtjpSDHMgolAcpGJveYtVAWzY4uSeZlmuieDqqfaCRrfzk1yP2uHek5RCXGkW
         HgHG5zDMhlIzFXL1XRhWZW9L3976VnXD5qU+VTjk=
Date:   Wed, 19 Feb 2020 13:46:45 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     kkabe@vega.pgw.jp, bhe@redhat.com, david@redhat.com,
        osalvador@suse.de, bugzilla-daemon@bugzilla.kernel.org,
        richardw.yang@linux.intel.com, n-horiguchi@ah.jp.nec.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH] memory_hotplug: disable the functionality for 32b
 (was: Re: [Bug 206401] kernel panic on Hyper-V after 5 minutes due to)
 memory hot-add
Message-Id: <20200219134645.7430db57e0e59f69e7386f46@linux-foundation.org>
In-Reply-To: <20200218100532.GA4151@dhcp22.suse.cz>
References: <20200218084700.GD21113@dhcp22.suse.cz>
        <200218181900.M0115079@vega.pgw.jp>
        <20200218100532.GA4151@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 18 Feb 2020 11:05:32 +0100 Michal Hocko <mhocko@kernel.org> wrote:

> Subject: [PATCH] memory_hotplug: disable the functionality for 32b
> 
> Memory hotlug is broken for 32b systems at least since c6f03e2903c9
> ("mm, memory_hotplug: remove zone restrictions") which has considerably
> reworked how can be memory associated with movable/kernel zones. The
> same is not really trivial to achieve in 32b where only lowmem is the
> kernel zone. While we can tweak this immediate problem around there are
> likely other land mines hidden at other places.
> 
> It is also quite dubious that there is a real usecase for the memory
> hotplug on 32b in the first place. Low memory is just too small to be
> hotplugable (for hot add) and generally unusable for hotremove. Adding
> more memory to highmem is also dubious because it would increase the
> low mem or vmalloc space pressure for memmaps.
> 
> Restrict the functionality to 64b systems. This will help future
> development to focus on usecases that have real life application.  We
> can remove this restriction in future in presence of a real life usecase
> of course but until then make it explicit that hotplug on 32b is broken
> and requires a non trivial amount of work to fix.

(cc linux-arch)

(and linux-arm-kernel, as ARM is a major 32-bit user)

Does anyone see a problem with disabling memory hotplug on 32-bit builds?
