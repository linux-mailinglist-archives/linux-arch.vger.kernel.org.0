Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB555497C3
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jun 2022 18:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbiFMQ30 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jun 2022 12:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240746AbiFMQ1u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jun 2022 12:27:50 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20321D2ADC;
        Mon, 13 Jun 2022 07:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655130094; x=1686666094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kRJcWACmO/lwAN79tjxhatvQLKzpV/YPdBZo5g5JtF4=;
  b=mPpiJqfy5J4n/YNIIrCPjYmeqaI8Qvoz8aNHxZv+xFMSXj18HGAJIs6+
   H4BTHzY1T2hlA/9D3KHiVWm0mi/cXiWNWZqOXq/PFsONNr9Ua0fAlnzf2
   ckzbreDh3doEfnBroLnhrXHxde+kPqB8aUk55BcaOEsceCgrvqcqnI3Px
   kiuyt2XgwF4JVsKoUtEq+PY6qsXoNbFkp8QNlEwmcM8r/IEkcA7sFp5+3
   H/oAIFySJjF4GKu6qWUxIMI3CV/zqec9/cNEtQEYAbajGdhuDTIyFSade
   EwVlmKIDZpIpG+b2yKcRpM7uG+pO1DtuSaVBdTQBko1Eten0QEmUQS1Zm
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10376"; a="277074388"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="277074388"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 07:21:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="761541888"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga005.jf.intel.com with ESMTP; 13 Jun 2022 07:21:22 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 25DELK2m022841;
        Mon, 13 Jun 2022 15:21:20 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Marco Elver <elver@google.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Yury Norov <yury.norov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] bitops: always define asm-generic non-atomic bitops
Date:   Mon, 13 Jun 2022 16:19:47 +0200
Message-Id: <20220613141947.1176100-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <CANpmjNNZAeMQjzNyXLeKY4cp_m-xJBU1vs7PgT+7_sJwxtEEAg@mail.gmail.com>
References: <20220610113427.908751-1-alexandr.lobakin@intel.com> <20220610113427.908751-3-alexandr.lobakin@intel.com> <YqNMO0ioGzJ1IkoA@smile.fi.intel.com> <22042c14bc6a437d9c6b235fbfa32c8a@intel.com> <CANpmjNNZAeMQjzNyXLeKY4cp_m-xJBU1vs7PgT+7_sJwxtEEAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Marco Elver <elver@google.com>
Date: Fri, 10 Jun 2022 18:32:36 +0200

> On Fri, 10 Jun 2022 at 18:02, Luck, Tony <tony.luck@intel.com> wrote:
> >
> > > > +/**
> > > > + * generic_test_bit - Determine whether a bit is set
> > > > + * @nr: bit number to test
> > > > + * @addr: Address to start counting from
> > > > + */
> > >
> > > Shouldn't we add in this or in separate patch a big NOTE to explain that this
> > > is actually atomic and must be kept as a such?
> >
> > "atomic" isn't really the right word. The volatile access makes sure that the
> > compiler does the test at the point that the source code asked, and doesn't
> > move it before/after other operations.
> 
> It's listed in Documentation/atomic_bitops.txt.

Oh, so my memory was actually correct that I saw it in the docs
somewhere.
WDYT, should I mention this here in the code (block comment) as well
that it's atomic and must not lose `volatile` as Andy suggested or
it's sufficient to have it in the docs (+ it's not underscored)?

> 
> It is as "atomic" as READ_ONCE() or atomic_read() is. Though you are
> right that the "atomicity" of reading one bit is almost a given,
> because we can't really read half a bit.
> The main thing is that the compiler keeps it "atomic" and e.g. doesn't
> fuse the load with another or elide it completely, and then transforms
> the code in concurrency-unfriendly ways.
> 
> Like READ_ONCE() and friends, test_bit(), unlike non-atomic bitops,
> may also be used to dependency-order some subsequent marked (viz.
> atomic) operations.
> 
> > But there is no such thing as an atomic test_bit() operation:
> >
> >         if (test_bit(5, addr)) {
> >                 /* some other CPU nukes bit 5 */
> >
> >                 /* I know it was set when I looked, but now, could be anything */
> 
> The operation itself is atomic, because reading half a bit is
> impossible. Whether or not that bit is modified concurrently is a
> different problem.
> 
> Thanks,
> -- Marco

Thanks,
Olek
