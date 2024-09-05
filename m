Return-Path: <linux-arch+bounces-7084-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E9396E359
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 21:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A8101F271A3
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 19:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778F3190047;
	Thu,  5 Sep 2024 19:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="qQrJHv8j"
X-Original-To: linux-arch@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F0518890F;
	Thu,  5 Sep 2024 19:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725565221; cv=none; b=UEwTyskL7FprcxzjN7aHcFczKhQsFGzqLRKr+eCKIiTyA4EFSPhWp4/73J8/l1x2Q4KmTp2DmmHmqaDz77VR5bJPcHJM5G5l8M8K2Zdk2vqbu8dXbG4Pn2+UnVkrf1E2Q+eQwd2pWJC2god80yF+R86wt3CF0fs4UEmxWFEOXWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725565221; c=relaxed/simple;
	bh=0njpqKLWluBDQGSUtohgju6AwFF6RyWPG2G9QwxX11E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l3ptDT4BJv0Q1jTupFwpoUj7R86+Z+3GlJEw2G8i+Yq7X/k2ABEYTwgtM3THGWhI1UXXI1LrLKQiN5cakqsfoV17r71ALo+URObzn57giA8YWf26sSsd4+ekcUaXGMaGFwMp3NWi4WT8f4U27zt+DgJKqq2AbADk+zloxTZscPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=qQrJHv8j; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 88C4142B25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1725565218; bh=SnvYuQFqEXegO9CMT7NfIUI17BcZjbXywADJx++0xlk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qQrJHv8jJYXwnnNG96FjPs0wS9EbXRw4l5iA8mYHJmyllP6iLyoNaMv5vVMMiVwNJ
	 /Qw7Y3bKI+Hr+mMVGQT0hEllXkDkIjRXxCv3i7LqWe6XhScGnb0c++SpAWdpCOP6S8
	 zCBsukWUjHd1nK3cfxKy2IM387n2tGR/tVfW2SZeh+lEkqasTj/2OZgwSq2XgHh0FZ
	 LUmXMEBm247jfwVHOxOSPa2Q+jgedXckqvmAxJ4A+8YlfxoylPviuNSJOso3yBlKwb
	 /6sDf/N6NJQxCZcku9VBfYvcnP/Vj8lCMy2MO71i28Fkj8Hk31itQvdChAPb/4cfx/
	 UNZdcqJKtOEXg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 88C4142B25;
	Thu,  5 Sep 2024 19:40:18 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Breno Leitao <leitao@debian.org>, Akinobu Mita <akinobu.mita@gmail.com>,
 Federico Vaga <federico.vaga@vaga.pv.it>, Akira Yokosawa
 <akiyks@gmail.com>, Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, Avadhut
 Naik <avadhut.naik@amd.com>, Alex Shi <alexs@kernel.org>, Yanteng Si
 <siyanteng@loongson.cn>, Hu Haowen <2023002089@link.tyut.edu.cn>, Jens
 Axboe <axboe@kernel.dk>, Kees Cook <kees@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alim
 Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, Bart
 Van Assche <bvanassche@acm.org>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: leit@meta.com, "Paul E. McKenney" <paulmck@kernel.org>, Thomas Huth
 <thuth@redhat.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, Thomas
 Gleixner <tglx@linutronix.de>, Xiongwei Song
 <xiongwei.song@windriver.com>, Ard Biesheuvel <ardb@kernel.org>, John Moon
 <john@jmoon.dev>, Vegard Nossum <vegard.nossum@oracle.com>, Miguel Ojeda
 <ojeda@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>,
 SeongJae Park <sj@kernel.org>, "Ran.Park" <ranpark@foxmail.com>, Tiezhu
 Yang <yangtiezhu@loongson.cn>, Remington Brasga <rbrasga@uci.edu>, Damien
 Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>, Chaitanya
 Kulkarni <kch@nvidia.com>, Johannes Thumshirn
 <johannes.thumshirn@wdc.com>, Zhu Yanjun <yanjun.zhu@linux.dev>, John
 Garry <john.g.garry@oracle.com>, Chengming Zhou
 <zhouchengming@bytedance.com>, Yu Kuai <yukuai3@huawei.com>, Shin'ichiro
 Kawasaki <shinichiro.kawasaki@wdc.com>, Vlastimil Babka <vbabka@suse.cz>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>, "open list:DOCUMENTATION PROCESS"
 <workflows@vger.kernel.org>, "open list:BLOCK LAYER"
 <linux-block@vger.kernel.org>, "open list:UNIVERSAL FLASH STORAGE HOST
 CONTROLLER DRIVER" <linux-scsi@vger.kernel.org>, "open list:GENERIC
 INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2] docs: Move fault injection section to dev-tools
In-Reply-To: <20240902125421.569668-1-leitao@debian.org>
References: <20240902125421.569668-1-leitao@debian.org>
Date: Thu, 05 Sep 2024 13:40:17 -0600
Message-ID: <87ttethota.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Breno Leitao <leitao@debian.org> writes:

> Fault injection is a development tool, and should be under dev-tools
> section.
>
> Suggested-by: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changelog:
>
> v2:
>   * Fixed a remaining file pointing to the wrong file, as reported by
>     kernel test robot:
> 	* https://lore.kernel.org/all/202408312350.DEf53QzI-lkp@intel.com/ 
>
> v1:
>   * https://lore.kernel.org/all/20240830174502.3732959-1-leitao@debian.org/
>
>  Documentation/admin-guide/kernel-parameters.txt              | 2 +-
>  .../{ => dev-tools}/fault-injection/fault-injection.rst      | 0
>  Documentation/{ => dev-tools}/fault-injection/index.rst      | 0
>  .../fault-injection/notifier-error-inject.rst                | 0
>  .../{ => dev-tools}/fault-injection/nvme-fault-injection.rst | 0
>  .../{ => dev-tools}/fault-injection/provoke-crashes.rst      | 0
>  Documentation/dev-tools/index.rst                            | 1 +
>  Documentation/index.rst                                      | 1 -
>  Documentation/process/4.Coding.rst                           | 2 +-
>  Documentation/process/submit-checklist.rst                   | 2 +-
>  Documentation/translations/it_IT/process/4.Coding.rst        | 2 +-
>  .../translations/it_IT/process/submit-checklist.rst          | 2 +-
>  Documentation/translations/ja_JP/SubmitChecklist             | 2 +-
>  .../translations/sp_SP/process/submit-checklist.rst          | 2 +-
>  Documentation/translations/zh_CN/index.rst                   | 2 +-
>  Documentation/translations/zh_CN/process/4.Coding.rst        | 2 +-
>  .../translations/zh_CN/process/submit-checklist.rst          | 2 +-
>  Documentation/translations/zh_TW/index.rst                   | 2 +-
>  Documentation/translations/zh_TW/process/4.Coding.rst        | 2 +-
>  .../translations/zh_TW/process/submit-checklist.rst          | 2 +-
>  MAINTAINERS                                                  | 2 +-
>  drivers/block/null_blk/main.c                                | 2 +-
>  drivers/misc/lkdtm/core.c                                    | 2 +-
>  drivers/ufs/core/ufs-fault-injection.c                       | 2 +-
>  include/asm-generic/error-injection.h                        | 5 +++--
>  include/linux/fault-inject.h                                 | 2 +-
>  lib/Kconfig.debug                                            | 4 ++--
>  tools/testing/fault-injection/failcmd.sh                     | 2 +-
>  28 files changed, 25 insertions(+), 24 deletions(-)
>  rename Documentation/{ => dev-tools}/fault-injection/fault-injection.rst (100%)
>  rename Documentation/{ => dev-tools}/fault-injection/index.rst (100%)
>  rename Documentation/{ => dev-tools}/fault-injection/notifier-error-inject.rst (100%)
>  rename Documentation/{ => dev-tools}/fault-injection/nvme-fault-injection.rst (100%)
>  rename Documentation/{ => dev-tools}/fault-injection/provoke-crashes.rst (100%)

Applied, thanks.

jon

