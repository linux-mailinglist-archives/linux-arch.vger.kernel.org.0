Return-Path: <linux-arch+bounces-1197-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD09981F4FD
	for <lists+linux-arch@lfdr.de>; Thu, 28 Dec 2023 07:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 721781F22526
	for <lists+linux-arch@lfdr.de>; Thu, 28 Dec 2023 06:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AFE5666;
	Thu, 28 Dec 2023 06:19:35 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C275393;
	Thu, 28 Dec 2023 06:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 038DE68B05; Thu, 28 Dec 2023 07:19:31 +0100 (CET)
Date: Thu, 28 Dec 2023 07:19:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org, linux-riscv@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 05/14] arm64: crypto: Use CC_FLAGS_FPU for NEON
 CFLAGS
Message-ID: <20231228061930.GB12475@lst.de>
References: <20231228014220.3562640-1-samuel.holland@sifive.com> <20231228014220.3562640-6-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228014220.3562640-6-samuel.holland@sifive.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


