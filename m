Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDD047D02A
	for <lists+linux-arch@lfdr.de>; Wed, 22 Dec 2021 11:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbhLVKnS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Dec 2021 05:43:18 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42824 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236501AbhLVKnS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Dec 2021 05:43:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A655861968;
        Wed, 22 Dec 2021 10:43:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99192C36AE8;
        Wed, 22 Dec 2021 10:43:15 +0000 (UTC)
Date:   Wed, 22 Dec 2021 10:43:12 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>, will@kernel.org,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, moyufeng@huawei.com,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH] asm-generic: introduce io_stop_wc() and add
 implementation for ARM64
Message-ID: <YcMBQEQ4e1zU3pJv@arm.com>
References: <20211217085611.111999-1-wangxiongfeng2@huawei.com>
 <YcLq//2odC3GrGvH@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcLq//2odC3GrGvH@infradead.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 22, 2021 at 01:08:15AM -0800, Christoph Hellwig wrote:
> So what is going to use this?

There was a series about 6 months ago making use of the new DGH arm64
instruction in a network driver:

https://lore.kernel.org/r/1627614864-50824-1-git-send-email-huangguangbin2@huawei.com

We bike-shedded on the name of the macro since (now settled on
io_stop_wc()) and there wasn't much point in carrying the rest of the
patches. I assume the driver changes will go in via their normal route
once the macro above is merged.

-- 
Catalin
