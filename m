Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01C229B5CF
	for <lists+linux-arch@lfdr.de>; Tue, 27 Oct 2020 16:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1796265AbgJ0PQT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Oct 2020 11:16:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1795066AbgJ0PPB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Oct 2020 11:15:01 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D95521D41;
        Tue, 27 Oct 2020 15:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603811701;
        bh=KcMcjP39WQb3PP6WZMwWmoTo3qIlZlixFqdmI1nRxjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lca6q57+3Tztb3zk1GZBAc7Igp4rDQBasPqGFInsMjLICkIsIDCfSUCR6LBML2n/Z
         m4j2cI6BoAL7HTxqr4vWM9XFxnGqcE7h48sykhRnlPDDdnmoEXRjrFo4RnCA8ebB//
         9/utw8+gxqTjkFlwU7jiwvGPU+y+WSP+X9hgG/JU=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
        palmerdabbelt@google.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-generic: mark __{get,put}_user_fn as __always_inline
Date:   Tue, 27 Oct 2020 16:14:53 +0100
Message-Id: <160381164874.4082358.6150613146628051056.b4-ty@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201027085017.3705228-1-hch@lst.de>
References: <20201027085017.3705228-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

On Tue, 27 Oct 2020 09:50:17 +0100, Christoph Hellwig wrote:
> Without the explicit __always_inline, some RISC-V configs place the
> functions out of line, triggering the BUILD_BUG_ON checks in the
> function.

Applied to asm-generic-fixes, thanks!

[1/1] asm-generic: mark __{get,put}_user_fn as __always_inline
      commit: 0bcd0a2be8c9ef39d84d167ff85359a49f7be175

       Arnd
