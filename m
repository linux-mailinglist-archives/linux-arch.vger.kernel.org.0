Return-Path: <linux-arch+bounces-4482-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692BE8CB260
	for <lists+linux-arch@lfdr.de>; Tue, 21 May 2024 18:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A5C61C20EB9
	for <lists+linux-arch@lfdr.de>; Tue, 21 May 2024 16:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2E41448CD;
	Tue, 21 May 2024 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fD3WuYjy"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D551CA80;
	Tue, 21 May 2024 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716309822; cv=none; b=POsFjimTzen2Stm+Jqk/O9iW12HGUiW4PZfjMH7uv+5GVYOP3XjPKkAft78TF+hCE0TNV0YgAd+uhK90up+BN5YX+mp6hCku40FlX8xTmZdBEZc/CD0ziJBXX9OjdRjNH1MZxxh/ubG3pVoChvOmqDtbx6cuHcTjfrzPEpp6zXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716309822; c=relaxed/simple;
	bh=v3vUZ+fHxZKCGYbCtA6MhT3zouHQA1W2ZrEaVPPX2wU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JuGt5D9Gt1Ucnlb/ag5oJSF8rT8baF8MQhEa6M6BllYMIB1/Uhvu4mq2gdiohTOqFcsZloeMtTAuVSf+MkdLKN1Oni1yYcH06quSwp60R5yc/hmb5TepU9HPzbYTq44ylZG3TakZoN6IumqTzYUwrpttLL9VqgP6c32nHhvdIB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fD3WuYjy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84422C2BD11;
	Tue, 21 May 2024 16:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716309822;
	bh=v3vUZ+fHxZKCGYbCtA6MhT3zouHQA1W2ZrEaVPPX2wU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fD3WuYjyxftV84YDlFyx0rHHTQPYLwkdScP/TVe8uhOVyRY8hYjADrHxi9HNgS5B+
	 893r8/GtQFk8ymSVU0nEV9qKemeLHETQUrDB/c7C6hb6JUHnfQPA0zOZCNPheHHd1I
	 chm4F1aeFEnpcJtrDi/yo2feyb+iBTDsP7WT+8w8uMUhJ9exH2ImPw4+1tjWgV5tzr
	 Bzg45VOtNnuXseepEaMAPtGhr0zMtElXJY/HCX/ybN0wzqU9vgLVDTF/+sScV9py4W
	 M9X2nM8nVL+aLFWmdjVeu4PPiWAkjIFSbJxc9swExy9RUin4ZpHCDHF3ZIZ5stukmG
	 Db1stfMy3ODFw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: kernel test robot <lkp@intel.com>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 amd-gfx@lists.freedesktop.org, bpf@vger.kernel.org,
 dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-arch@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
 netdev@vger.kernel.org, nouveau@lists.freedesktop.org
Subject: Re: [linux-next:master] BUILD REGRESSION
 124cfbcd6d185d4f50be02d5f5afe61578916773
In-Reply-To: <202405220033.NXFpd4Af-lkp@intel.com>
References: <202405220033.NXFpd4Af-lkp@intel.com>
Date: Tue, 21 May 2024 18:43:38 +0200
Message-ID: <87wmnncdz9.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

kernel test robot <lkp@intel.com> writes:

> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-n=
ext.git master
> branch HEAD: 124cfbcd6d185d4f50be02d5f5afe61578916773  Add linux-next spe=
cific files for 20240521

[...]

> Error/Warning ids grouped by kconfigs:
>
> gcc_recent_errors

[...]

> |-- riscv-randconfig-r054-20240521
> |   `--
> drivers-irqchip-irq-riscv-imsic-early.c:error:too-many-arguments-to-funct=
ion-riscv_ipi_set_virq_range

FWIW, discussion/patch here [1]


Bj=C3=B6rn

[1] https://lore.kernel.org/linux-riscv/mhng-10b71228-cf3e-42ca-9abf-5464b1=
5093f1@palmer-ri-x1c9/

