Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C09F54CB0E
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jun 2022 16:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241081AbiFOOTj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jun 2022 10:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238011AbiFOOTf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jun 2022 10:19:35 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DEC36B7E;
        Wed, 15 Jun 2022 07:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655302774; x=1686838774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y34PZ1MCfO2hOMDdvHaZPFb/IY8bQc2YzesGXP5aW7I=;
  b=A/oFOIEr34NCwX17DN63AvAkOvGSGISwyuYbqnrT4q5UJ8WiplXZN2yu
   SbtgglgRKSu8OIldwMfB0oZmlbgBbHQ0ksK/nNA1oUq8sirIzOV8Dq8Ji
   PtmhZZHzRJexQUgUUwkYu3QpKFcpRnO48SszAN1SJNJAhdNHMXQxH2czf
   5AV7g52+ulqSJ94o58TiGx51TuYmqo1JjyijCasgQoB32gQ6fP+oKipy7
   +9EN80FJQJRansLOVIR5HouAx7MoEJ6bRfty5MkoGyIPik95P0qHeskXf
   v4ZVjkAB6WdmLfcLueKtKxnw7OhX7dNevRNYbnSz+Mdv2MobxhGUeoD6W
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="304408545"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="304408545"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 07:19:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="831065704"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga006.fm.intel.com with ESMTP; 15 Jun 2022 07:19:29 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 25FEJRYo024307;
        Wed, 15 Jun 2022 15:19:27 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Yury Norov <yury.norov@gmail.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alpha <linux-alpha@vger.kernel.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] bitops: let optimize out non-atomic bitops on compile-time constants
Date:   Wed, 15 Jun 2022 16:17:32 +0200
Message-Id: <20220615141732.1265627-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <CAMuHMdVayS6hV3CWW6FS-1cQKoGTCDxgVhZVPSyBMvJHBxVwJA@mail.gmail.com>
References: <20220610113427.908751-1-alexandr.lobakin@intel.com> <CAMuHMdUZCaPN2B6bvmja9rDm3qCc4mYYAOSEB2W0R0pws8peqw@mail.gmail.com> <20220613142645.1176423-1-alexandr.lobakin@intel.com> <CAMuHMdVayS6hV3CWW6FS-1cQKoGTCDxgVhZVPSyBMvJHBxVwJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Jun 2022 17:22:30 +0200

> Hi Olek,

Hi!

> 
> On Mon, Jun 13, 2022 at 4:28 PM Alexander Lobakin
> <alexandr.lobakin@intel.com> wrote:
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > > On Fri, Jun 10, 2022 at 1:35 PM Alexander Lobakin
> > > <alexandr.lobakin@intel.com> wrote:
> > > On m68k, using gcc version 9.4.0 (Ubuntu 9.4.0-1ubuntu1~20.04), this
> > > blows up immediately with:
> >
> > Yeah I saw the kernel bot report already, sorry for that >_< Fixed
> > in v3 already, will send in 1-2 days.
> 
> Is it simple to fix?
> I might be able to give the fixed v2 a try before that.
> Thanks!

Oh, sorry for the late reply, was busy with stuff.
It's linear, there are (after applying the series) some static
inlines in arch/m68k/include/asm/bitops.h (those which were
converted from macros in patch 3/6), 7 ops in total, you just need
to create definitions with 'arch_' prefix for each of them, e.g.

#define arch_test_bit	test_bit
#define arch___set_bit	__set_bit // will be ___set_bit after 5/6

etc.
Hope I explained it clear-ish :)

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

Thanks,
Olek
