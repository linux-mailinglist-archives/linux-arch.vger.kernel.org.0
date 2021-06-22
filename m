Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D52E3AFA4E
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jun 2021 02:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhFVAsj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Jun 2021 20:48:39 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:56467 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbhFVAsj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Jun 2021 20:48:39 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 15M0kNwa035486
        for <linux-arch@vger.kernel.org>; Tue, 22 Jun 2021 03:46:23 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1624322777; x=1626914777;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0TIRxIkkteAzwssAi+Hquy4jV1LNAzUACaNk/lpu6ew=;
        b=o0fdKLodMohtHshXDEq8hARatX0xabreVNwHrHMQWImCnCFn6ep0idKk/EOR4NXv
        /FQKsPndB+8o4mbmcwBPNpepmlZ9r3x6BsRyrSNJxxMSgH0ce6UNNx7efv6yMFqq
        wp/v2TdlOCgFY2p09yGgMivS3YxdQWYB8AUuVLZKbvq+1wN6mHGuG8CHrcyWMRvk
        gFKiVMe1ZkJj+wPWBUmxK3Xq7OsFRdZCv0jIjsoUHUpuSgF8HI+lQKCBibpTXW2N
        qhkliIkVjFHoLLY6D9K5rOr7qz2QRXLbvL/xUeVDwEKLTyMn2ZSSMvFUSBSKNE3S
        UFfITKPcba/Ia5+02Q/oFQ==;
X-AuditID: 8b5b014d-962f1700000067b6-be-60d132d912be
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 51.60.26550.9D231D06; Tue, 22 Jun 2021 03:46:17 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 22 Jun 2021 03:46:16 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        Bin Meng <bmeng.cn@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v3 2/3] riscv: optimized memmove
Organization: FORTH
In-Reply-To: <20210617152754.17960-3-mcroce@linux.microsoft.com>
References: <20210617152754.17960-1-mcroce@linux.microsoft.com>
 <20210617152754.17960-3-mcroce@linux.microsoft.com>
Message-ID: <3a71b234ec05b6ce842a3d6da552ba30@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsXSHT1dWfem0cUEg+etphbb3l1lsdj6exa7
        xaIV31kspvbEW+xYupnJ4t6KZewWL/Y2slg8WTOT0aJj11cWi8u75rBZbPvcwmZx8dd8RouX
        l3uYLdpm8TvwefTPnsLm8e73MkaPNy9fsngc7vjC7tHR94/FY+esu+wem1Z1snn82n6UyWPz
        knqPS83X2T0+b5LzaD/QzRTAE8Vlk5Kak1mWWqRvl8CV8e/mJ/aC2VwVb7p6mRsYv7J3MXJy
        SAiYSDx+9JG1i5GLQ0jgKKPEpXnnoRKmErP3djKC2LwCghInZz5hAbGZBSwkpl7Zzwhhy0s0
        b53NDGKzCKhKbJi9CyzOJqApMf/SQbB6EQFdiYsfDrODLGAWmM4i8at3NxtIQhhoc/Pm32DL
        +AWEJT7dvcgKYnMKOEh8fHUUaCgH0EWlEt+mSIOYvAIuElfvMkOcpiLx4fcDdpCwKJC9ea7S
        BEbBWUgOnYXk0FlIDl3AyLyKUSCxzFgvM7lYLy2/qCRDL71oEyM46hh9dzDe3vxW7xAjEwfj
        IUYJDmYlEd6bKRcShHhTEiurUovy44tKc1KLDzFKc7AoifPy6k2IFxJITyxJzU5NLUgtgsky
        cXBKNTCtTvvKU9XsfPFo3RE1d42rAq0v93HvCIsxPZrR3HmNo4rlLG/p8TjzdVwFIsX5jvce
        rKn+WSJ/OkK4pNy67NXmjtYG5TYDptLLXFp3N+9cnfTqkGmileeTAP/AxBT35fHnTFoKU1p/
        l1ndjP5+3lW3fer6VaYOzdpr9LNbFyVdydj02G9V3Y4PIodjvmbFKUgH1bJGWq97s+xTWIPP
        nBmixyvU3z/6s1e0+8jbGasn1C/vOsb1gTGhIrXVsl7/iHf1h/lKJzt5l3x9WPk6KnV+scCF
        1E3hh8Xzvk065R8a/F1jVtC0x0ujQ1Y3n/zz9Otfmzl57/3sdgkZyN5K+1iUmKF+/JfYT2G+
        Kp35vkosxRmJhlrMRcWJAEYP1ZkpAwAA
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Στις 2021-06-17 18:27, Matteo Croce έγραψε:
> +
> +/*
> + * Simply check if the buffer overlaps an call memcpy() in case,
> + * otherwise do a simple one byte at time backward copy.
> + */
> +void *__memmove(void *dest, const void *src, size_t count)
> +{
> +	if (dest < src || src + count <= dest)
> +		return memcpy(dest, src, count);
> +
> +	if (dest > src) {
> +		const char *s = src + count;
> +		char *tmp = dest + count;
> +
> +		while (count--)
> +			*--tmp = *--s;
> +	}
> +	return dest;
> +}
> +EXPORT_SYMBOL(__memmove);
> +

Copying backwards byte-per-byte is suboptimal, I understand this is not 
a very common scenario but you could at least check if they are both 
word-aligned e.g. (((src + len) | (dst + len)) & mask), or missaligned 
by the same offset e.g. (((src + len) ^ (dst + len)) & mask) and still 
end up doing word-by-word copying. Ideally it would be great if you 
re-used the same technique you used for forwards copying on your memcpy.

> +void *memmove(void *dest, const void *src, size_t count) __weak
> __alias(__memmove);
> +EXPORT_SYMBOL(memmove);

As I mentioned on your memcpy patch, if you implement memmove, you can 
just alias memcpy to memmove and we won't have to worry about memcpy 
being used on overlapping regions.
