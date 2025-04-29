Return-Path: <linux-arch+bounces-11681-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FF3AA062E
	for <lists+linux-arch@lfdr.de>; Tue, 29 Apr 2025 10:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2AF480FFD
	for <lists+linux-arch@lfdr.de>; Tue, 29 Apr 2025 08:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FDC28934B;
	Tue, 29 Apr 2025 08:50:38 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76397279347;
	Tue, 29 Apr 2025 08:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745916638; cv=none; b=qOjqaDU0GMmEvO+mpcBbSVBbdnqP57twnfbAlRcP/+yOJ2DmgSbH/q0fBIHCfOrMOq3v3JR6g1F47qyip67t/FrABh6zRmk06Cu4xGAiPh5wH6Hs5dP4GR8JFhYpWX22/p1FJCdFmqgrCKkKD7FkeW0TSAtG09Ft38aCgw7IVGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745916638; c=relaxed/simple;
	bh=6C2TMS+n6qqj5M83V5ptzbHpW40e+AmDHnNCpPTAXdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t5eoK39GHJVxFvL2PADcfoUMuOSQhG5sS2nzrD2nF681IPXkQa6QHRO7a7wwQzBK0Uu2W9TSHkWiwdIQtFI/MCL2iTQ5Mb3wD0OiUohQL6K/6Zq+UUmEvM7fQrYS4fhuIqorRqeRtwEvi2hAJzYin3cyUVXEn1GnghSkWfsXgRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4ZmtbH6JVvz9sFT;
	Tue, 29 Apr 2025 10:22:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e30qWr8CZO0g; Tue, 29 Apr 2025 10:22:19 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4ZmtbG0699z9sCk;
	Tue, 29 Apr 2025 10:22:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id F1CD98B766;
	Tue, 29 Apr 2025 10:22:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 2CpqnVV7VgEF; Tue, 29 Apr 2025 10:22:17 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3E7F68B763;
	Tue, 29 Apr 2025 10:22:17 +0200 (CEST)
Message-ID: <df566157-5320-47cf-ae14-a2e578f68a35@csgroup.eu>
Date: Tue, 29 Apr 2025 10:22:16 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/13] crypto: powerpc - drop redundant dependencies on
 PPC
To: Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, x86@kernel.org,
 "Jason A . Donenfeld" <Jason@zx2c4.com>, Ard Biesheuvel <ardb@kernel.org>
References: <20250422152716.5923-1-ebiggers@kernel.org>
 <20250422152716.5923-3-ebiggers@kernel.org>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250422152716.5923-3-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 22/04/2025 à 17:27, Eric Biggers a écrit :
> From: Eric Biggers <ebiggers@google.com>
> 
> arch/powerpc/crypto/Kconfig is sourced only when CONFIG_PPC=y, so there
> is no need for the symbols defined inside it to depend on PPC.
> 
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Eric Biggers <ebiggers@google.com>


Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Note that there are other redundancies in the file, for instance 
CONFIG_VSX already depends on CONFIG_PPC64

Christophe


