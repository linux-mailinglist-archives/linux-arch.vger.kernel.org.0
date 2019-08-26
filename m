Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 945D69C987
	for <lists+linux-arch@lfdr.de>; Mon, 26 Aug 2019 08:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbfHZGi0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Aug 2019 02:38:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54920 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729260AbfHZGi0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Aug 2019 02:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/cTefX4WriggdI6xhCa46FySFPWkgwoZoZ9aeiu49hA=; b=XIOGeVHaCMWHYSZ9wmgjF2NFC
        PTwXn2qYkGpq+fMW7LX+UATKkUuM5w26sjIMRKCQ8PagJDIdum11NIfubHvureFR7OQRuchBlr7RO
        6izRKXx55CuysG9Zv7vnhxbHSIkGlKTpbUYdbI4MBXPFrBfDRLMs7aaLNST+loT1uU8Ldkiy1Aznz
        SSE41Nx1ExYQeiXd1PUydNdlgFgpx2UWyo7/5HFO77VoPQY4mqtltHiiL2ON0qT8QfHs8m+uYu02K
        hBECoAa+O9qLrIrPwXYPS49s3fWAiT1yUxfG61yCzAQNmP8Y5qUTu5YuvpVnMDogGukC5Ce1T9nFB
        tDfPs4sMg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i28du-0007y0-F9; Mon, 26 Aug 2019 06:38:18 +0000
Date:   Sun, 25 Aug 2019 23:38:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, hch@infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
        douzhk@nationalchip.com, Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V2] csky: Fixup 610 vipt cache flush mechanism
Message-ID: <20190826063818.GA29871@infradead.org>
References: <1566443122-17540-1-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566443122-17540-1-git-send-email-guoren@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 22, 2019 at 11:05:22AM +0800, guoren@kernel.org wrote:
> From: Guo Ren <ren_guo@c-sky.com>
> 
> 610 has vipt aliasing issue, so we need to finish the cache flush
> apis mentioned in cachetlb.rst to avoid data corruption.
> 
> Here is the list of modified apis in the patch:

Looks sensible to me, although I can't really verify the details.
You might also want to Cc linux-mm.
