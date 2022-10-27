Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC5360F45D
	for <lists+linux-arch@lfdr.de>; Thu, 27 Oct 2022 12:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbiJ0KDl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Oct 2022 06:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbiJ0KDS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Oct 2022 06:03:18 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCDF8BCBA;
        Thu, 27 Oct 2022 03:03:13 -0700 (PDT)
Received: from anrayabh-desk (unknown [167.220.238.193])
        by linux.microsoft.com (Postfix) with ESMTPSA id F007A210D86A;
        Thu, 27 Oct 2022 03:03:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F007A210D86A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1666864993;
        bh=pn5m/fsuZt2o/sMJ3Kn65n/0LQdWBVSALoeLYn13kis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BThGiM/wSe52io/Na6nHbCaIO+y+/fTPYtARe06SNx7lqq/Albe4ZBQtIfdGy5UWQ
         wtwLuEnHqfslFG8LwSBUtlpUbdD5gid4c3igIcQ0h7V4Ojd2SzhPVRDZ9XesVShyoJ
         SD++xnCACEu8BRi7ZB8IzqtyTfnR1oGmcvOd6CX8=
Date:   Thu, 27 Oct 2022 15:33:03 +0530
From:   Anirudh Rayabharam <anrayabh@linux.microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kumarpraveen@linux.microsoft.com" <kumarpraveen@linux.microsoft.com>,
        "mail@anirudhrb.com" <mail@anirudhrb.com>
Subject: Re: [PATCH 0/2] Fix MSR access errors during kexec in root partition
Message-ID: <Y1pXV8mpjVLH9KvB@anrayabh-desk>
References: <20221026134715.1438789-1-anrayabh@linux.microsoft.com>
 <BYAPR21MB1688DBC9CA80E03BDC7643E2D7309@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB1688DBC9CA80E03BDC7643E2D7309@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 26, 2022 at 02:57:58PM +0000, Michael Kelley (LINUX) wrote:
> From: Anirudh Rayabharam <anrayabh@linux.microsoft.com> Sent: Wednesday, October 26, 2022 6:47 AM
> > 
> > Fixes a couple of MSR access errors seen during kexec in root partition
> > and opportunistically introduces a data structure for the reference TSC
> > MSR in order to simplify the code that updates that MSR.
> > 
> > Anirudh Rayabharam (2):
> >   x86/hyperv: fix invalid writes to MSRs during root partition kexec
> >   clocksource/drivers/hyperv: add data structure for reference TSC MSR
> 
> Could these two patches be sequenced in the opposite order, to avoid the
> need to change the TSC code in hyperv_cleanup() twice?  The new
> data structure for the Reference TSC MSR and clocksource driver changes
> would be in the first patch.  Then the second patch would update
> hyperv_cleanup() and could use the new data structure.

I just sent a new version with the ordering you suggested.

Thanks,
Anirudh.

> 
> Michael
> 
> > 
> >  arch/x86/hyperv/hv_init.c          | 11 +++++++----
> >  drivers/clocksource/hyperv_timer.c | 28 ++++++++++++++--------------
> >  include/asm-generic/hyperv-tlfs.h  |  9 +++++++++
> >  3 files changed, 30 insertions(+), 18 deletions(-)
> > 
> > --
> > 2.34.1
