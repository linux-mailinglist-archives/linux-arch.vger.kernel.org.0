Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C192161118A
	for <lists+linux-arch@lfdr.de>; Fri, 28 Oct 2022 14:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJ1MeX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Oct 2022 08:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ1MeW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Oct 2022 08:34:22 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCAFD1CCCEB;
        Fri, 28 Oct 2022 05:34:20 -0700 (PDT)
Received: from anrayabh-desk (unknown [167.220.238.193])
        by linux.microsoft.com (Postfix) with ESMTPSA id 824D320FFC13;
        Fri, 28 Oct 2022 05:34:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 824D320FFC13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1666960460;
        bh=uYtQX/93qPpjMaza7pg50g5p9DP9YkcPmRuJLi5ikKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FOShQ1JpVKxAnKbVhnSrS93F8qmVh6zy4qtsOPJVMpnShta0BKrRYnsB1ZMYaU8gj
         VjGY+D43tHJPKWWIOevQXphQQdaMhA45EaJYLuz9PH4Ow00oV4AWeYls7c/dFptzal
         a2V3u1m2c5dp5AZunBYIfw5zIFuDLbdgmTso7eJo=
Date:   Fri, 28 Oct 2022 18:04:10 +0530
From:   Anirudh Rayabharam <anrayabh@linux.microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
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
        "stanislav.kinsburskiy@gmail.com" <stanislav.kinsburskiy@gmail.com>,
        "kumarpraveen@linux.microsoft.com" <kumarpraveen@linux.microsoft.com>,
        "mail@anirudhrb.com" <mail@anirudhrb.com>
Subject: Re: [PATCH v2 2/2] x86/hyperv: fix invalid writes to MSRs during
 root partition kexec
Message-ID: <Y1vMQo51EiaNbE1V@anrayabh-desk>
References: <20221027095729.1676394-1-anrayabh@linux.microsoft.com>
 <20221027095729.1676394-3-anrayabh@linux.microsoft.com>
 <BYAPR21MB168872A298C1CDC140FBF454D7339@BYAPR21MB1688.namprd21.prod.outlook.com>
 <Y1rZIQnLATztxw2G@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1rZIQnLATztxw2G@liuwe-devbox-debian-v2>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 27, 2022 at 07:16:49PM +0000, Wei Liu wrote:
> On Thu, Oct 27, 2022 at 01:44:40PM +0000, Michael Kelley (LINUX) wrote:
> > From: Anirudh Rayabharam <anrayabh@linux.microsoft.com> Sent: Thursday, October 27, 2022 2:57 AM
> > > 
> > > hv_cleanup resets the hypercall page by setting the MSR to 0. However,
> > 
> > The function name is hyperv_cleanup(), not hv_cleanup().
> 
> I fixed this and applied both patches to hyperv-fixes. Thank you both.

Thank you!

Anirudh.
