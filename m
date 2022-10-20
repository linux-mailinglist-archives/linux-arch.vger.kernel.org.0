Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE066065E5
	for <lists+linux-arch@lfdr.de>; Thu, 20 Oct 2022 18:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiJTQe0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Oct 2022 12:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiJTQeZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Oct 2022 12:34:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F3B17D288;
        Thu, 20 Oct 2022 09:34:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A24BFB826A9;
        Thu, 20 Oct 2022 16:34:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED493C433D7;
        Thu, 20 Oct 2022 16:34:09 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ladaFUCN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666283647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j6/3/s/F9AiqZ8ACkktuUlP8j8csHgAdMQTJ3xPu0RU=;
        b=ladaFUCNFHYEdS+B5lBVsUu7VOyg2l1LsONGKpmaJE+SQOzJeKVPlPFPd6VRQMtvOsKnrQ
        Fbc98kpAvzczoJ0ualK85kOyjs0aW1klyXlXUWaIfjIJqLFmYapVadnDOv0pFQ7zpifsOl
        gHzeoVDoUomAff/UMawkFmbDk12k7KI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 49be7ccd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 20 Oct 2022 16:34:06 +0000 (UTC)
Received: by mail-ua1-f51.google.com with SMTP id y20so9978880uao.8;
        Thu, 20 Oct 2022 09:34:06 -0700 (PDT)
X-Gm-Message-State: ACrzQf0FLEp+HUka5qpbpFxwBy7ZurjveFakUSMekepBsywVxhZo3KrX
        CjqH+dqjqLSKND25CcoZWnnTISV22IbmAUWC9Rg=
X-Google-Smtp-Source: AMsMyM4UbgKYinuY1PeLlQUJ+zAbDnXOqoO0YgQNW243VlJSovQbjZ4gksu4qa/PVM5AIgL5W9c5Duh97XLbOtbizJw=
X-Received: by 2002:a05:6102:7c9:b0:3a7:6261:935 with SMTP id
 y9-20020a05610207c900b003a762610935mr7838965vsg.73.1666283644745; Thu, 20 Oct
 2022 09:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <20221019162648.3557490-1-Jason@zx2c4.com> <202210201618.8XhEGsLd-lkp@intel.com>
In-Reply-To: <202210201618.8XhEGsLd-lkp@intel.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 20 Oct 2022 10:33:53 -0600
X-Gmail-Original-Message-ID: <CAHmME9pqXvoYZL4u3dzfQDNyDB3TbaMAkynn=MLqagC_Dmk6TQ@mail.gmail.com>
Message-ID: <CAHmME9pqXvoYZL4u3dzfQDNyDB3TbaMAkynn=MLqagC_Dmk6TQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: treat char as always signed
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        kbuild-all@lists.01.org, Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 20, 2022 at 2:40 AM kernel test robot <lkp@intel.com> wrote:
> >> drivers/s390/block/dasd.c:1912:9: warning: case label value exceeds maximum value for type [-Wswitch-outside-range]
>     1912 |         case DASD_CQR_ERROR:

Just to save other readers the momentary "huh?" that I experienced,
this warning/error is from the -fsigned-char patch. We ultimately went
with (or are trying to go with) the -funsigned-char approach instead.
So safely ignore this kernel test bot error, as it applies to v1
rather than the v2 here:
https://lore.kernel.org/lkml/20221019203034.3795710-1-Jason@zx2c4.com/

Jason
