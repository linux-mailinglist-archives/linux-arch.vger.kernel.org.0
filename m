Return-Path: <linux-arch+bounces-1033-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0263B812874
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 07:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F7F21F219F9
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 06:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35CED29E;
	Thu, 14 Dec 2023 06:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EVnZVPpI"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D783AE8;
	Wed, 13 Dec 2023 22:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VwDqvg57fzCjHeJdXQ7BKuFaBbLUlDwICUOjyFt1o7I=; b=EVnZVPpIbtKeIVxC8cbCE7CybH
	N+cb0xIJOPkXPCIcA5H6+1skRis2ohr+DGrdC3+VNabal/xsWOulv3Uuzl4gDSgf+tAWYCX7K8m5C
	+V2v4pp1sdxOhqm21zGTSXPi1RIaWc7XphvBq9SnftALgj80W2gVbdtk2ZI7icT6oa3CtUwvXwC8z
	IjXmUVnVhZeRina4K/EqAFaXLXXoQmyTxQ6XjrpUDbeSi+dSdLV0qJUUv1RaRqfERvQR50KD5HHD+
	M2fWRD2dfxjSJnmpmvRjDY5FBQ7UnQIsv/6fm48fZ+iIyp3VYKZlumWz9ndHkbCqOun8e92nBmZoV
	ATVH3uPQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rDfWj-00H1dE-0o;
	Thu, 14 Dec 2023 06:48:57 +0000
Date: Wed, 13 Dec 2023 22:48:57 -0800
From: Christoph Hellwig <hch@infradead.org>
To: patchwork-bot+netdevbpf@kernel.org
Cc: Mina Almasry <almasrymina@google.com>, shailend@google.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, corbet@lwn.net, jeroendb@google.com,
	pkaligineedi@google.com, hawk@kernel.org,
	ilias.apalodimas@linaro.org, arnd@arndb.de, dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com, shuah@kernel.org,
	sumit.semwal@linaro.org, christian.koenig@amd.com,
	linyunsheng@huawei.com, hramamurthy@google.com, shakeelb@google.com
Subject: Re: [net-next v1 00/16] Device Memory TCP
Message-ID: <ZXqlWT2JYg0sa7IF@infradead.org>
References: <20231208005250.2910004-1-almasrymina@google.com>
 <170253482786.28524.10625748175644260187.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170253482786.28524.10625748175644260187.git-patchwork-notify@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Dec 14, 2023 at 06:20:27AM +0000, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:

Umm, this is still very broken in intraction with other subsystems.
Please don't push ahead so quickly.


