Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB11E9D2D8
	for <lists+linux-arch@lfdr.de>; Mon, 26 Aug 2019 17:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732475AbfHZPeE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Aug 2019 11:34:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57672 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728350AbfHZPeE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Aug 2019 11:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gZm47CCL06ybTiP0j0dAUiXrO053lQFsUW6pDmole3U=; b=UqypIqh27pmKxahyd/0HFg4Cv
        n2pfzS8CIpKBqOvjlsL+BytTAwLBa7XX4Te99ClELPy+d6q/sRzkJE+9nxQNh2J+hpOfPAVlL6gbS
        ODK1jdLTWrIR1+90tvC+hWF10IqiXcWn1WwxoRuLQGTtb7SKjO3MpYRC8ykny/BM2dyVx57MuPD92
        uweHAZeaM8hj+vpVpTvjrYFG7Y9xq/HrUJXXh1Zpx7w1t90DFPoQy3T1HZpAYWSjXdIV/InCHD61Q
        ULT09gMcukaJ+YSgmQ1sP3tY2piDlndjgODjYT+BmGb0OoztGdv0ejl5MAserwJL6DNbB9oxxZCpX
        FpZ4hrrYA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i2H0L-0000VW-Qf; Mon, 26 Aug 2019 15:34:01 +0000
Date:   Mon, 26 Aug 2019 08:34:01 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mark.rutland@arm.com, peterz@infradead.org,
        catalin.marinas@arm.com, takahiro.akashi@linaro.org,
        james.morse@arm.com, hidehiro.kawai.ez@hitachi.com,
        tglx@linutronix.de, will@kernel.org, dave.martin@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 0/7] Unify SMP stop generic logic to common code
Message-ID: <20190826153401.GB9591@infradead.org>
References: <20190823115720.605-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823115720.605-1-cristian.marussi@arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 23, 2019 at 12:57:13PM +0100, Cristian Marussi wrote:
> An architecture willing to rely on this SMP common logic has to define its
> own helpers and set CONFIG_ARCH_USE_COMMON_SMP_STOP=y.
> The series wire this up for arm64.
> 
> Behaviour is not changed for architectures not adopting this new common
> logic.

Seens like this common code only covers arm64.  I think we should
generally have at least two users for common code.
