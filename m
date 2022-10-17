Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CCC600E93
	for <lists+linux-arch@lfdr.de>; Mon, 17 Oct 2022 14:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiJQML1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Oct 2022 08:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiJQML0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Oct 2022 08:11:26 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00161616D;
        Mon, 17 Oct 2022 05:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666008686; x=1697544686;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vw+vsrxvR88sMwvNZcFQAh9PSKUEFTkb+Zwafmh+7Zc=;
  b=fWOZnyW+oiYTGSuZbbfMz3vA0vqVNmuyt4y769FIYAh6qzXNqEx7ykFf
   IOiAwtIIYAEbev+TI3Rhlsz6lx7/wDwqV6gjFfT53m/+VV23p5ygT8Tk+
   7LIlE5FD+f42MAZkXbiPtXh2C3wmxm0kuO/aggOloMoUd5qua4aS21/Jy
   rtKBM3uLRELeYcC5pzfwERkdGUahEgPqpcCycb2k1RL/Vm69oPVaMqE4S
   slspkDgAXrVVDSvSW9Ru0AjW/jkHA1tlPihIxTCUaQ6wOh2cxSJ2E4nhs
   1E9FY6wUB+UNDV6acnwluNZy7LvOjjsA7Z+UT8CJlCwKWTLPqWNMSJJJb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="306860556"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="306860556"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 05:11:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="691335698"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="691335698"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 17 Oct 2022 05:11:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1okOxh-008mX9-1M;
        Mon, 17 Oct 2022 15:11:17 +0300
Date:   Mon, 17 Oct 2022 15:11:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Keerthy <j-keerthy@ti.com>, Russell King <linux@armlinux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Davide Ciminaghi <ciminaghi@gnudd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 0/9] gpio: Get rid of ARCH_NR_GPIOS (v2)
Message-ID: <Y01GZV/RHezVaGdC@smile.fi.intel.com>
References: <cover.1662116601.git.christophe.leroy@csgroup.eu>
 <CAMRc=MehcpT84-ucLbYmdVTAjT86bNb9NEfV6npCmPZHqbsArw@mail.gmail.com>
 <b348a306-3043-4ccc-9067-81759ab29143@www.fastmail.com>
 <CACRpkdbazHcUassRMqZ2oHmama3nWEZ3U3bB-y-3dmo3jgFPWg@mail.gmail.com>
 <a7cb856c-8a3f-4737-ae9e-b75c306ad88e@www.fastmail.com>
 <da8e0775-7d3e-d6fa-e1ff-395769d35614@csgroup.eu>
 <CAMRc=MdNnUS72cSARv8dAVUsujkUM9jyjutJsty9o+=LOkOefg@mail.gmail.com>
 <CAMRc=MeZUap-h=NZm1L0BfN2=ms6VeOJA+05HPyLq_hE8kVuEQ@mail.gmail.com>
 <CACRpkdYPCZ9QAwNripOXGuFgvtnC+vzQ5EbYaWJEF1u9E_x4Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYPCZ9QAwNripOXGuFgvtnC+vzQ5EbYaWJEF1u9E_x4Yw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 17, 2022 at 11:06:49AM +0200, Linus Walleij wrote:
> On Mon, Oct 17, 2022 at 11:05 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

...

> Let's test it in linux-next we need wide coverage for this.

Yes, I believe the best if we can have this in the Linux Next as long as
possible before going to upstream. This is good change that needs good testing
coverage.

Speaking of the latter, and a bit of offtopic, I want to send a PR of cleaning
up the headers in pin control subsystem as soon as possible with the same
rationale underneath, i.e. testing and new drivers using a cleaned up headers..

-- 
With Best Regards,
Andy Shevchenko


