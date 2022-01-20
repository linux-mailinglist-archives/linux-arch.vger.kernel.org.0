Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A3B4951DB
	for <lists+linux-arch@lfdr.de>; Thu, 20 Jan 2022 16:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376818AbiATP4x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Jan 2022 10:56:53 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45368 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376814AbiATP4x (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Jan 2022 10:56:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB76C6137B;
        Thu, 20 Jan 2022 15:56:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34CCC340E0;
        Thu, 20 Jan 2022 15:56:50 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     arnd@arndb.de, Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, huangguangbin2@huawei.com
Subject: Re: [PATCH] asm-generic: Add missing brackets for io_stop_wc macro
Date:   Thu, 20 Jan 2022 15:56:48 +0000
Message-Id: <164269417314.2457156.16366204630518149172.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220114105857.126300-1-wangxiongfeng2@huawei.com>
References: <20220114105857.126300-1-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 14 Jan 2022 18:58:57 +0800, Xiongfeng Wang wrote:
> After using io_stop_wc(), drivers reports following compile error when
> compiled on X86.
> 
>   drivers/net/ethernet/hisilicon/hns3/hns3_enet.c: In function ‘hns3_tx_push_bd’:
>   drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:2058:12: error: expected ‘;’ before ‘(’ token
>     io_stop_wc();
>               ^
> It is because I missed to add the brackets after io_stop_wc macro. So
> let's add the missing brackets.
> 
> [...]

Applied to arm64 (for-next/core), thanks!

[1/1] asm-generic: Add missing brackets for io_stop_wc macro
      https://git.kernel.org/arm64/c/440323b6cf5b

-- 
Catalin

