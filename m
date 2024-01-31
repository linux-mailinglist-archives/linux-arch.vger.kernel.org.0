Return-Path: <linux-arch+bounces-1955-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A78E844AC9
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 23:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47554285DB9
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 22:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6395C39FCF;
	Wed, 31 Jan 2024 22:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2672yQQj"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F242439AFF;
	Wed, 31 Jan 2024 22:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706739106; cv=none; b=DttgA2Lyyna6E5cfICu5tbEBWaGoct44/jcpDA1jN+YdUvfMUsrapX7YG/8a8upk/e/tCY+tczt8zs9ykw/efVuVPA3Etd0Qdim3JiYUtSk2c3TgJKHR3qk+7QqwunWU2GQj4aRakOfgtVVIyhf10aJZDYeTq7eRbFPw//Ocv1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706739106; c=relaxed/simple;
	bh=U2SkNI0/X2V6vLQDt7VO/avYOGSFIc3TRnmmMPgR8AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKPyzvoxZ1azoe8pxBNB9q2qweSTNrqtsbtBcoLLqgpgmePJPkJj9Tc654z0ZuJ6o/CFhAPkcBc1mb/7AOYVwkJyy4lK1C6/BdBpGxe9SMIlAm+dCnxVUyKapCcDSPpCVb0FfXgTE6YPjqWMwUz9lu8ot4+RZHinAX1wzoAabVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2672yQQj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EYJkjP6OdtGkECm36A4ixj1YutK17AGbMSAVYgvaIhI=; b=2672yQQjEehKlUjCrLZkV3dVo2
	f2bMYbRUBGCrN8ACFo630uYJL4qIQ5tRsGP4/9+/E4SZIh34dHl7ZL/0sDXG4amS2xKUWc7XImkX/
	MYWCp2v1MLlSolKeYvzHuszssWRNKHd1ppKs7BA1jEWOXPRlD7ICWprSqF96qiOTeCmXjTsjWZRZQ
	Ta1JWgk0VFVTJ28enq40D0QAqxLlCk+UAoxs8zFBovsAshX+5eLiXGXdC+8jNiPD3wU/a7sM5+icH
	AUQOQuaD9WssW6QTDHoGPuzvKPBxaYZM1s9k2xV6hM7s1uXl7kk1W8GR0N4uPjhrDsES+ZG8yNqHT
	2cJBNO5g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVIo4-00000005fEM-2Cnb;
	Wed, 31 Jan 2024 22:11:44 +0000
Date: Wed, 31 Jan 2024 14:11:44 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: masahiroy@kernel.org, deller@gmx.de
Cc: arnd@arndb.de, linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] modules: few of alignment fixes
Message-ID: <ZbrFoKUJQ8MIdzXD@bombadil.infradead.org>
References: <20240129192644.3359978-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129192644.3359978-1-mcgrof@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Mon, Jan 29, 2024 at 11:26:39AM -0800, Luis Chamberlain wrote:
> Masahiro, if there no issues feel free to take this or I can take them in
> too via the modules-next tree. Lemme know!

I've queued this onto modules-testing to get winder testing [0]

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=modules-testing

  Luis

