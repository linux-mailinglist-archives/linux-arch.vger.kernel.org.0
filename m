Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55D920288B
	for <lists+linux-arch@lfdr.de>; Sun, 21 Jun 2020 06:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgFUEge (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 21 Jun 2020 00:36:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgFUEgd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 21 Jun 2020 00:36:33 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1CD22477E;
        Sun, 21 Jun 2020 04:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592714193;
        bh=8Is6WO1ey0nQPFB5gupTXkIMpseo8Kyx5Z9+J6XFIkI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2rSDacdxSmtNbeXB/ki+X88EqpfdIdcDJEKcMmIXrAzCrCdYgyA3hT2pQk1pUfChv
         vK5yopJzDZa0Wly1PQ2bK427zhV5HMATTDrTudmt3qj4Awdvk8QFCf27vfUnRCV2Fs
         nqhY4BNtfsskJODq/AP2dfkTx7McM4F/3THyy/qo=
Date:   Sat, 20 Jun 2020 21:36:32 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     andy.shevchenko@gmail.com, arnd@arndb.de, emil.l.velikov@gmail.com,
        geert@linux-m68k.org, keescook@chromium.org,
        linus.walleij@linaro.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com, syednwaris@gmail.com,
        vilhelm.gray@gmail.com, yamada.masahiro@socionext.com
Subject: Re: [PATCH v3 2/2] bits: Add tests of GENMASK
Message-Id: <20200620213632.60c2c6b99ec9cf9392fa128d@linux-foundation.org>
In-Reply-To: <20200608221823.35799-2-rikard.falkeborn@gmail.com>
References: <20200608184222.GA899@rikard>
        <20200608221823.35799-1-rikard.falkeborn@gmail.com>
        <20200608221823.35799-2-rikard.falkeborn@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue,  9 Jun 2020 00:18:23 +0200 Rikard Falkeborn <rikard.falkeborn@gmail.com> wrote:

> Add tests of GENMASK and GENMASK_ULL.
> 
> A few test cases that should fail compilation are provided
> under #ifdef TEST_GENMASK_FAILURES

WARNING: modpost: missing MODULE_LICENSE() in lib/test_bits.o


Could you please send a fix?
