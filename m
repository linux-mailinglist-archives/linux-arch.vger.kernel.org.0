Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C442A47D0F6
	for <lists+linux-arch@lfdr.de>; Wed, 22 Dec 2021 12:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244637AbhLVL0i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Dec 2021 06:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244647AbhLVL0g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Dec 2021 06:26:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC8EC061574;
        Wed, 22 Dec 2021 03:26:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F421B81A4F;
        Wed, 22 Dec 2021 11:26:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2738C36AE5;
        Wed, 22 Dec 2021 11:26:30 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     will@kernel.org, Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        corbet@lwn.net, mark.rutland@arm.com, peterz@infradead.org
Cc:     moyufeng@huawei.com, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] asm-generic: introduce io_stop_wc() and add implementation for ARM64
Date:   Wed, 22 Dec 2021 11:26:28 +0000
Message-Id: <164017237365.157899.5054701495946891448.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211221035556.60346-1-wangxiongfeng2@huawei.com>
References: <20211221035556.60346-1-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 21 Dec 2021 11:55:56 +0800, Xiongfeng Wang wrote:
> For memory accesses with write-combining attributes (e.g. those returned
> by ioremap_wc()), the CPU may wait for prior accesses to be merged with
> subsequent ones. But in some situation, such wait is bad for the
> performance.
> 
> We introduce io_stop_wc() to prevent the merging of write-combining
> memory accesses before this macro with those after it.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] asm-generic: introduce io_stop_wc() and add implementation for ARM64
      https://git.kernel.org/arm64/c/d5624bb29f49

-- 
Catalin

