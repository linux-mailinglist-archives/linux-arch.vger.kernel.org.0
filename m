Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7B03B416
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2019 13:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389532AbfFJLhS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jun 2019 07:37:18 -0400
Received: from mail.codeweavers.com ([50.203.203.244]:33844 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389346AbfFJLhR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jun 2019 07:37:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/SHmrx2OGszMojwi0lkosVsMjx6Rojf4MNms94FoV6s=; b=fXJ3tPQbcxZUY4oPTr+zNREb2
        +TZVfbKrwmmpFX0cNPelz/zBugEAZq3q+j53J1q82ddkA15wUt52LnzMYzBHR580J5t182ToSyJ3h
        BOU7JidlIXFf0Nm8TND3eg0KC+FRUjmi23Cg8Bk7TbKCiBGyqEm706PZ+pFNELL2d0L4c=;
Received: from merlot.physics.ox.ac.uk ([163.1.241.98] helo=merlot)
        by mail.codeweavers.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <huw@codeweavers.com>)
        id 1haIcW-0005Ee-5w; Mon, 10 Jun 2019 06:37:49 -0500
Received: from daviesh by merlot with local (Exim 4.90_1)
        (envelope-from <huw@codeweavers.com>)
        id 1haIbs-0003Fy-Tx; Mon, 10 Jun 2019 12:37:09 +0100
Date:   Mon, 10 Jun 2019 12:37:08 +0100
From:   Huw Davies <huw@codeweavers.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v6 01/19] kernel: Standardize vdso_datapage
Message-ID: <20190610113708.GE11076@merlot.physics.ox.ac.uk>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190530141531.43462-2-vincenzo.frascino@arm.com>
 <20190610092751.GA11076@merlot.physics.ox.ac.uk>
 <58cedde2-0d54-7d2d-f519-77cb71f543fd@arm.com>
 <20190610103151.GD11076@merlot.physics.ox.ac.uk>
 <83ab2758-0e8c-35d5-906a-0338bcee3310@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83ab2758-0e8c-35d5-906a-0338bcee3310@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Score: -106.0
X-Spam-Report: Spam detection software, running on the system "mail.codeweavers.com",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Mon, Jun 10, 2019 at 12:07:45PM +0100, Vincenzo Frascino
    wrote: > On 10/06/2019 11:31, Huw Davies wrote: > > On Mon, Jun 10, 2019
   at 11:17:48AM +0100, Vincenzo Frascino wrote: > >> On 10/06/2019 10 [...] 
 Content analysis details:   (-106.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -100 USER_IN_WHITELIST      From: address is in the user's white-list
 -6.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 10, 2019 at 12:07:45PM +0100, Vincenzo Frascino wrote:
> On 10/06/2019 11:31, Huw Davies wrote:
> > On Mon, Jun 10, 2019 at 11:17:48AM +0100, Vincenzo Frascino wrote:
> >> On 10/06/2019 10:27, Huw Davies wrote:
> >>> On Thu, May 30, 2019 at 03:15:13PM +0100, Vincenzo Frascino wrote:
> >>>> --- /dev/null
> >>>> +++ b/include/vdso/datapage.h
> >>>> @@ -0,0 +1,91 @@
> >>>> +/* SPDX-License-Identifier: GPL-2.0 */
> >>>> +#ifndef __VDSO_DATAPAGE_H
> >>>> +#define __VDSO_DATAPAGE_H
> >>>> +
> >>>> +#ifdef __KERNEL__
> >>>> +
> >>>> +#ifndef __ASSEMBLY__
> >>>> +
> >>>> +#include <linux/bits.h>
> >>>> +#include <linux/time.h>
> >>>> +#include <linux/types.h>
> >>>> +
> >>>> +#define VDSO_BASES	(CLOCK_TAI + 1)
> >>>> +#define VDSO_HRES	(BIT(CLOCK_REALTIME)		| \
> >>>> +			 BIT(CLOCK_MONOTONIC)		| \
> >>>> +			 BIT(CLOCK_BOOTTIME)		| \
> >>>> +			 BIT(CLOCK_TAI))
> >>>> +#define VDSO_COARSE	(BIT(CLOCK_REALTIME_COARSE)	| \
> >>>> +			 BIT(CLOCK_MONOTONIC_COARSE))
> >>>> +#define VDSO_RAW	(BIT(CLOCK_MONOTONIC_RAW))
> >>>> +
> >>>> +#define CS_HRES_COARSE	0
> >>>> +#define CS_RAW		1
> >>>
> >>> CS_HRES_COARSE seems like a confusing name choice to me.  What you
> >>> really mean is not RAW.
> >>>
> >>> How about CS_ADJ to indicate that its updated by adjtime?
> >>> CS_XTIME might be another option.
> >>>
> >>
> >> I divided the timers in 3 sets (HRES, COARSE, RAW), CS_HRES_COARSE refers to the
> >> first two and CS_RAW to the third. I will ad a comment to explain the logic in
> >> the next iteration.
> > 
> > I'm thinking ahead about a possible CLOCK_MONOTONIC_RAW_COARSE (which
> > would be useful at least for Wine).  In that case you'd have four clock
> > types non-raw and raw, each with either hres or coarse.
> > 
> 
> Thanks for this, I was not aware of CLOCK_MONOTONIC_RAW_COARSE.
> I tried to find, though, some details, but I could not find any. Could you
> please provide some reference?

It doesn't exist yet ;-)  However it doesn't seem crazy that such a
clock should exist.  I was really using it to illustrate that
raw / non-raw is orthogonal to hres / coarse.

That being said, this really doesn't matter that much.

Huw.
