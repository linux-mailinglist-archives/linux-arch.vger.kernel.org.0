Return-Path: <linux-arch+bounces-1200-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A60781F503
	for <lists+linux-arch@lfdr.de>; Thu, 28 Dec 2023 07:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064641F22623
	for <lists+linux-arch@lfdr.de>; Thu, 28 Dec 2023 06:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9FE256C;
	Thu, 28 Dec 2023 06:21:03 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24014409;
	Thu, 28 Dec 2023 06:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CB7F168D05; Thu, 28 Dec 2023 07:20:57 +0100 (CET)
Date: Thu, 28 Dec 2023 07:20:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org, linux-riscv@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 13/14] selftests/fpu: Move FP code to a separate
 translation unit
Message-ID: <20231228062057.GE12475@lst.de>
References: <20231228014220.3562640-1-samuel.holland@sifive.com> <20231228014220.3562640-14-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228014220.3562640-14-samuel.holland@sifive.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


