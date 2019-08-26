Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2668D9D2D3
	for <lists+linux-arch@lfdr.de>; Mon, 26 Aug 2019 17:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbfHZPck (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Aug 2019 11:32:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55304 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728350AbfHZPck (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Aug 2019 11:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BArM4GoPxHZk+c8mtmgknU72vcsySDFgQe3HMfzQChA=; b=YjZYTjmPkkBrsF6aKyM6r/8Xc
        XsjaySbRItts5lT467fparlmye0XBJrz8S05M5OYrtl4wuJLMEyxjbhGVaQ6Xp/5NVugGvJ2cNizs
        xn6zBHCmLDv1cnjxuxTOBlH9247oewU3fwdFLvOj0VW5cG0wxAC9MgJnSw7vMpkiRhbhfNCQVrzMu
        EBNv5TYbBfowCjZgTKeyDf1GVUddr8c4wOBXF9KKkKKjBTFhf9gZviNivh7gyNicsKjS5hKS5Jja8
        NyTGq9o7S8sBkLeLHQnxai3u0ZUgJkFZpP60GOMVzVc2tWOyvIf2Xi8Ytw4FuOw4gRv8EOykQJ2N0
        AeWAXKFyg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i2Gyy-0008VN-LN; Mon, 26 Aug 2019 15:32:36 +0000
Date:   Mon, 26 Aug 2019 08:32:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mark.rutland@arm.com, peterz@infradead.org,
        catalin.marinas@arm.com, takahiro.akashi@linaro.org,
        james.morse@arm.com, hidehiro.kawai.ez@hitachi.com,
        tglx@linutronix.de, will@kernel.org, dave.martin@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 5/7] arm64: smp: use generic SMP stop common code
Message-ID: <20190826153236.GA9591@infradead.org>
References: <20190823115720.605-1-cristian.marussi@arm.com>
 <20190823115720.605-6-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823115720.605-6-cristian.marussi@arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> +config ARCH_USE_COMMON_SMP_STOP
> +	def_bool y if SMP

The option belongs into common code and the arch code shoud only
select it.
