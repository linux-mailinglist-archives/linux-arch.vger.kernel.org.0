Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A597B6C9A9F
	for <lists+linux-arch@lfdr.de>; Mon, 27 Mar 2023 06:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjC0Erj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Mar 2023 00:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjC0Eri (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Mar 2023 00:47:38 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB2B34C3A;
        Sun, 26 Mar 2023 21:47:37 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 2E9CB20FD0D3; Sun, 26 Mar 2023 21:47:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2E9CB20FD0D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1679892457;
        bh=NIilwokkVveAW1/qoyF+G5KzDatqErPlzzHGZDvChIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IA1L8cUT6IpC78sM9ct3eZR1fTaqg1TOJzmdnWntQD8qMPBc4sDsl878GyhoIYl9B
         33HHNFeMOeVxYZj2zvAkVIzlxS0OICsDwNAy9QCuebMGg3Kycd4qVv4QvcUlrW5HFk
         lPdS2Tyq0pgprfQZDe7fMXftYVXOjiYLJQ+pvVKM=
Date:   Sun, 26 Mar 2023 21:47:37 -0700
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] x86/init: Make get/set_rtc_noop() public
Message-ID: <20230327044737.GA6852@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1679306618-31484-1-git-send-email-ssengar@linux.microsoft.com>
 <1679306618-31484-2-git-send-email-ssengar@linux.microsoft.com>
 <BYAPR21MB16885E11E5112939F59FD0BFD78A9@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB16885E11E5112939F59FD0BFD78A9@BYAPR21MB1688.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-17.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Mar 26, 2023 at 03:03:17PM +0000, Michael Kelley (LINUX) wrote:
> From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Monday, March 20, 2023 3:04 AM
> > 
> > Make get/set_rtc_noop() to be public so that they can be used
> > in other modules as well.
> > 
> > Co-developed-by: Tianyu Lan <tiala@microsoft.com>
> > Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > Reviewed-by: Wei Liu <wei.liu@kernel.org>
> > ---
> >  arch/x86/include/asm/x86_init.h | 2 ++
> >  arch/x86/kernel/x86_init.c      | 4 ++--
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
> > index c1c8c581759d..d8fb3a1639e9 100644
> > --- a/arch/x86/include/asm/x86_init.h
> > +++ b/arch/x86/include/asm/x86_init.h
> > @@ -326,5 +326,7 @@ extern void x86_init_uint_noop(unsigned int unused);
> >  extern bool bool_x86_init_noop(void);
> >  extern void x86_op_int_noop(int cpu);
> >  extern bool x86_pnpbios_disabled(void);
> > +extern int set_rtc_noop(const struct timespec64 *now);
> > +extern void get_rtc_noop(struct timespec64 *now);
> > 
> >  #endif
> > diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
> > index ef80d361b463..d93aeffec19b 100644
> > --- a/arch/x86/kernel/x86_init.c
> > +++ b/arch/x86/kernel/x86_init.c
> > @@ -33,8 +33,8 @@ static int __init iommu_init_noop(void) { return 0; }
> >  static void iommu_shutdown_noop(void) { }
> >  bool __init bool_x86_init_noop(void) { return false; }
> >  void x86_op_int_noop(int cpu) { }
> > -static __init int set_rtc_noop(const struct timespec64 *now) { return -EINVAL; }
> > -static __init void get_rtc_noop(struct timespec64 *now) { }
> > +int set_rtc_noop(const struct timespec64 *now) { return -EINVAL; }
> > +void get_rtc_noop(struct timespec64 *now) { }
> > 
> >  static __initconst const struct of_device_id of_cmos_match[] = {
> >  	{ .compatible = "motorola,mc146818" },
> > --
> > 2.34.1
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>


Hi x86 maintainers,

If there is no concern, can you please ack this patch.


Regards,
Saurabh

