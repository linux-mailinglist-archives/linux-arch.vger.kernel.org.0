Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FC865CF2C
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jan 2023 10:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238969AbjADJJE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Jan 2023 04:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238962AbjADJI4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Jan 2023 04:08:56 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3157B1B;
        Wed,  4 Jan 2023 01:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672823335; x=1704359335;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=3mQDFqK56sHAmt7h6/PT2gUmDW4yEy/kTINyMDMkyjQ=;
  b=Er+2MlmESHFMjso/DHjBFJmBXpW5gfjTcCctXzRKOruv2dF/AU6FQrYk
   Y6R0vH6YIKL9iOhMt+TSAnUGP6TN+4bpYkCs0q2OzcDSwFSoQyo+3OZhT
   z+q2iuuVBH3bxk3/HEI648jECI/vFlr8b39awX9+rFKbO1oKdzUdktVH5
   DLQdKtEhpFLJzE9nbkve/xSFwsEe5Ik6kdPp/A5bfPQ6z62gfg4zKWdMq
   P9uyHmrmXxpCbtNAi5ref6hDuNgMDkbqhV0A6oooX8V7AWpAKXfS+YCxJ
   5MddJuk8szJ1dP0h+MFe+ii4ckxZkj/v+q58Qb6A27YWh7n2KPI+BTxqD
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="320598673"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="320598673"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 01:08:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="655122391"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="655122391"
Received: from mkabdel-mobl.ger.corp.intel.com (HELO localhost) ([10.252.25.63])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 01:08:47 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-arch@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 1/1] gpio: Remove unused and obsoleted
 gpio_export_link()
In-Reply-To: <20230102210850.25320-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230102210850.25320-1-andriy.shevchenko@linux.intel.com>
Date:   Wed, 04 Jan 2023 11:08:45 +0200
Message-ID: <871qoazmxu.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 02 Jan 2023, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> gpio_export_link() is legacy and unused API, remove it for good.

This seemed vaguely familiar, and true enough, adding that was my 5th
ever commit to the kernel. :)

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
