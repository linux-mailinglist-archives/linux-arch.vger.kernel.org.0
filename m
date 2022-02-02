Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA224A6C7F
	for <lists+linux-arch@lfdr.de>; Wed,  2 Feb 2022 08:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiBBHwF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Feb 2022 02:52:05 -0500
Received: from verein.lst.de ([213.95.11.211]:33222 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231368AbiBBHwE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Feb 2022 02:52:04 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id D45AE67373; Wed,  2 Feb 2022 08:51:59 +0100 (CET)
Date:   Wed, 2 Feb 2022 08:51:59 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     guoren@kernel.org
Cc:     palmer@dabbelt.com, arnd@arndb.de, anup@brainfault.org,
        gregkh@linuxfoundation.org, liush@allwinnertech.com,
        wefu@redhat.com, drew@beagleboard.org, wangjunqiang@iscas.ac.cn,
        hch@lst.de, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V5 15/21] riscv: compat: Add hw capability check for elf
Message-ID: <20220202075159.GB18398@lst.de>
References: <20220201150545.1512822-1-guoren@kernel.org> <20220201150545.1512822-16-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201150545.1512822-16-guoren@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 01, 2022 at 11:05:39PM +0800, guoren@kernel.org wrote:
> +bool compat_elf_check_arch(Elf32_Ehdr *hdr)
> +{
> +	if (compat_mode_support && (hdr->e_machine == EM_RISCV))
> +		return true;
> +	else
> +		return false;
> +}

This can be simplified to:

	return compat_mode_support && hdr->e_machine == EM_RISCV;

I'd also rename compat_mode_support to compat_mode_supported

> +
> +static int compat_mode_detect(void)
> +{
> +	unsigned long tmp = csr_read(CSR_STATUS);
> +
> +	csr_write(CSR_STATUS, (tmp & ~SR_UXL) | SR_UXL_32);
> +
> +	if ((csr_read(CSR_STATUS) & SR_UXL) != SR_UXL_32) {
> +		pr_info("riscv: 32bit compat mode detect failed\n");
> +		compat_mode_support = false;
> +	} else {
> +		compat_mode_support = true;
> +		pr_info("riscv: 32bit compat mode detected\n");
> +	}

I don't think we need these printks here.

Also this could be simplified to:

	compat_mode_supported = (csr_read(CSR_STATUS) & SR_UXL) == SR_UXL_32;
