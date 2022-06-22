Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E075554A01
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jun 2022 14:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234689AbiFVMZB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jun 2022 08:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbiFVMZA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jun 2022 08:25:00 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B20733E08;
        Wed, 22 Jun 2022 05:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655900700; x=1687436700;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nRwykYNWJOMVjV6KXtUwB8jzGM4hq74AzeD0f7K2mG8=;
  b=oA4zzjp38HoavGgm25b3i5YBxG5ycm5OwmmkeqlAIAfAosMhtMhw+C88
   nD39BBEJ8P4v06p/wPJlHvVipcVYhVhpPlLtBbwIL0OqLjvs6+nbEzOj9
   clrf9HCk/2zZepmtkxkDQmyV3eJGaQS4Kv3nu0SiopBEVtY5Xg7GNX9e1
   RSOv/aVaeeq0OjjYI2lr6TpRNu+y7P3wOkJzRggPLxLMuDLNkAPBjELTZ
   5RueQINTxsbsdEw/Uued6PvM1+Lij2X3dRmK8hjp28xgxkoQb7UBd3Dkj
   FSF/ayGdwVJHemUmznwW7oM5m4iXMY69updWPv7ryRhoc3xd13q3fZ9VF
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="260832176"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="260832176"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 05:24:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="620892409"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga001.jf.intel.com with ESMTP; 22 Jun 2022 05:24:53 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 25MCOp8S011366;
        Wed, 22 Jun 2022 13:24:51 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/8] bitops: let optimize out non-atomic bitops on compile-time constants
Date:   Wed, 22 Jun 2022 14:24:40 +0200
Message-Id: <20220622122440.87087-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621191553.69455-1-alexandr.lobakin@intel.com>
References: <20220621191553.69455-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Tue, 21 Jun 2022 21:15:45 +0200

> While I was working on converting some structure fields from a fixed
> type to a bitmap, I started observing code size increase not only in
> places where the code works with the converted structure fields, but
> also where the converted vars were on the stack. That said, the
> following code:

[...]

Oh gosh, now s390 failed and 7/8 revealed one existing code flaw in
the ice driver.
I'll fix those, then will try to test more platforms (to not spam
series again) and send v5 soon (mentioning this as bots CCs only
myself).

> -- 
> 2.36.1

Thanks,
Olek
