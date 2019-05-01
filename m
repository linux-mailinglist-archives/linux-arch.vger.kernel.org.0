Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8BB10C24
	for <lists+linux-arch@lfdr.de>; Wed,  1 May 2019 19:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfEARkX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 May 2019 13:40:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34818 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfEARkX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 May 2019 13:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QqltW55b8MUQJ4hT00KXOPTP8JAvi8T4BIhthG30Yx4=; b=Siqt2t2t4zEqN0iLnZ24k3d+G
        m82DDcwqoZT5k50q5BTCcMKa9H/ZjhdrxxVMbvw0X84aALXe96hXoi+M8jXdAaMkLtfD35nXhwQ/j
        j6v9Eqb9c5oEJHEWYzvOkaM3yRkKH/AOTh4DbKtkliloZyGQIToOHq3cjzZMuJTIG1lexvBOCqwV2
        3JZvLH8Bcv0R/w5z0VAfKIQezaMIteokjtW3COC7nesut2A/fcsLFphoXc9+z38BaT7MkEB9u9i4y
        g+IucfVsN5mxw4RRjt9zVQdSFpTp4DwV9+waGcdbovSiuEsdfpHbvAzIiThaSOoECuJM3rY2rDeAz
        SZCd2toTA==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLtDQ-0005te-Ro; Wed, 01 May 2019 17:40:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: remove asm-generic/ptrace.h
Date:   Wed,  1 May 2019 13:39:38 -0400
Message-Id: <20190501173943.5688-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

asm-generic/ptrace.h is a little weird in that it doesn't actually
implement any functionality, but it provided multiple layers of macros
that just implement trivial inline functions.  We implement those
directly in the few architectures and be off with a much simpler
design.
