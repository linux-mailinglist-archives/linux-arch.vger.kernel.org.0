Return-Path: <linux-arch+bounces-1161-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C59B781C4E5
	for <lists+linux-arch@lfdr.de>; Fri, 22 Dec 2023 07:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 588E4B2106D
	for <lists+linux-arch@lfdr.de>; Fri, 22 Dec 2023 06:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFB963C3;
	Fri, 22 Dec 2023 06:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mGXygDlC"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A53463B5;
	Fri, 22 Dec 2023 06:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kzr5HLA4G8uGXrzh0OIgj/7iyn4tEAeSJOAhhi8/1Hc=; b=mGXygDlCGTEr5bPVz3Q76bEHQA
	0uXSMJ8XwyV+03beVUcO12k4XGePx65UxGKrYcx4fzcX5abGy4KyLpoeMIWw51HcMKMEIQNlWzeyj
	aXNEATWL0iV85Ftmu7fLirS/SQhQZeuLGxEAnqBc/BYFlxVJyg9rMon8GzeRlLPIxg6gGwTjMqKqq
	u1xnXFgalI/zzWQV6fz6HtcAMQ0aT3v0a62Lv4//dMZhPcj9F0BjVJoQviY3ZhIBPvyumkOksk43r
	n3hzGTkx9QWW/0KFON5qwDjlh9+OZDPg/0S0tHz2y1kJn073fKni+zIkhkOhfy6hQ1XtMMhJL9dmq
	tWX8TJPg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rGYiL-0052wH-3D;
	Fri, 22 Dec 2023 06:08:54 +0000
Date: Thu, 21 Dec 2023 22:08:53 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: deller@kernel.org, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, linux-modules@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/4] linux/export: Fix alignment for 64-bit ksymtab
 entries
Message-ID: <ZYUn9c4z9yFWMeH4@bombadil.infradead.org>
References: <20231122221814.139916-1-deller@kernel.org>
 <20231122221814.139916-2-deller@kernel.org>
 <CAK7LNAQ4C66NZpOwM6_pzdFbTx7LHfv40vJsNu3spPCEJKfOFw@mail.gmail.com>
 <CAK7LNARN985trrbxnCY0+wv5q2ie9PO0TvKet1aLBzDdP-xHPA@mail.gmail.com>
 <ZYUnkSF6hcyPq9tG@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYUnkSF6hcyPq9tG@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, Dec 21, 2023 at 10:07:13PM -0800, Luis Chamberlain wrote:
> 
> If we want to go bananas we could even get a graph of size of modules

Sorry I meant size of number of symbols Vs cost.

 Luis

