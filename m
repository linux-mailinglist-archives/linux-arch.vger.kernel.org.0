Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88732549CA4
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jun 2022 21:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346930AbiFMTBl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jun 2022 15:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346540AbiFMTAy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jun 2022 15:00:54 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588794D9C1;
        Mon, 13 Jun 2022 09:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655137612; x=1686673612;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XxsfHurYfgtl5B8eDXs3NdPaSjArXVczaB+F2Bn9Ek4=;
  b=HkYwqi5rbxVLCa9DjzarYkrq7QLAZ9qJ+s2gNJJwnWp97qJXWFbwlbvj
   IgCLX29aH7yIYuWMl01dpUNPIDxsoDHK4/eQASqiKWGDvI7LVFYFOfpoZ
   g8qKp7GTjIwLLvVwojxp+7wVKL0jJf3q5LYQL07wmecV23KQqc7jHX9mj
   FEcLj7QyRIoInFaPDChRUQRrILOt9Vq3z6+jiYvoFTjl2qp74Svl0d3kW
   qsR2JrznwCwY6XBuyr1iQ89ASkG0udTU0SoUX6lbIM6ZwLEMi1NB0RSz8
   uZYyXaT9sqqRa1ZQkBo7IDws7JCuI55fqO+uj+L+shaJqgZTeOOenbFo3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="303733996"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="303733996"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 09:26:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="611858233"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 13 Jun 2022 09:26:50 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 13 Jun 2022 09:26:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 13 Jun 2022 09:26:49 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.027;
 Mon, 13 Jun 2022 09:26:49 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Lobakin, Alexandr" <alexandr.lobakin@intel.com>,
        Marco Elver <elver@google.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Yury Norov <yury.norov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/6] bitops: always define asm-generic non-atomic
 bitops
Thread-Topic: [PATCH v2 2/6] bitops: always define asm-generic non-atomic
 bitops
Thread-Index: AQHYfL4xWJEoq3eTcEeKREBjFjjrHK1JHg2A//+t5kCAAH9LAIAEkeOA//+tDzA=
Date:   Mon, 13 Jun 2022 16:26:49 +0000
Message-ID: <c82877aa7cc244f2bf0f65dfb2b617e7@intel.com>
References: <20220610113427.908751-1-alexandr.lobakin@intel.com>
 <20220610113427.908751-3-alexandr.lobakin@intel.com>
 <YqNMO0ioGzJ1IkoA@smile.fi.intel.com>
 <22042c14bc6a437d9c6b235fbfa32c8a@intel.com>
 <CANpmjNNZAeMQjzNyXLeKY4cp_m-xJBU1vs7PgT+7_sJwxtEEAg@mail.gmail.com>
 <20220613141947.1176100-1-alexandr.lobakin@intel.com>
In-Reply-To: <20220613141947.1176100-1-alexandr.lobakin@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

>> It's listed in Documentation/atomic_bitops.txt.
>
> Oh, so my memory was actually correct that I saw it in the docs
> somewhere.
> WDYT, should I mention this here in the code (block comment) as well
> that it's atomic and must not lose `volatile` as Andy suggested or
> it's sufficient to have it in the docs (+ it's not underscored)?

I think a comment that the "volatile" is required to prevent re-ordering
is enough.

But maybe others are sufficiently clear on the meaning? I once wasted
time looking for the non-atomic __test_bit() version (to use in some code
that was already protected by a spin lock, so didn't need the overhead
of an "atomic" version) before realizing there wasn't a non-atomic one.

-Tony
