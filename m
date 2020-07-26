Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A2422DD46
	for <lists+linux-arch@lfdr.de>; Sun, 26 Jul 2020 10:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgGZIc0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 26 Jul 2020 04:32:26 -0400
Received: from elvis.franken.de ([193.175.24.41]:49123 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbgGZIcX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 26 Jul 2020 04:32:23 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jzc4y-0004Hg-04; Sun, 26 Jul 2020 10:32:20 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 5D564C0A2D; Sun, 26 Jul 2020 10:32:06 +0200 (CEST)
Date:   Sun, 26 Jul 2020 10:32:06 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Bibo Mao <maobibo@loongson.cn>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Paul Burton <paulburton@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/2] MIPS: Set page access bit with pgprot on
 platforms with RIXI
Message-ID: <20200726083206.GE5032@alpha.franken.de>
References: <1591416169-26666-1-git-send-email-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591416169-26666-1-git-send-email-maobibo@loongson.cn>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jun 06, 2020 at 12:02:48PM +0800, Bibo Mao wrote:
> @@ -158,23 +158,23 @@ void __update_cache(unsigned long address, pte_t pte)
>  static inline void setup_protection_map(void)
>  {
>  	if (cpu_has_rixi) {
> -		protection_map[0]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
> -		protection_map[1]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC);
> -		protection_map[2]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
> -		protection_map[3]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC);
> -		protection_map[4]  = __pgprot(_page_cachable_default | _PAGE_PRESENT);
> -		protection_map[5]  = __pgprot(_page_cachable_default | _PAGE_PRESENT);
> -		protection_map[6]  = __pgprot(_page_cachable_default | _PAGE_PRESENT);
> -		protection_map[7]  = __pgprot(_page_cachable_default | _PAGE_PRESENT);
> -
> -		protection_map[8]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
> -		protection_map[9]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC);
> -		protection_map[10] = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE | _PAGE_NO_READ);
> -		protection_map[11] = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE);
> -		protection_map[12] = __pgprot(_page_cachable_default | _PAGE_PRESENT);
> -		protection_map[13] = __pgprot(_page_cachable_default | _PAGE_PRESENT);
> -		protection_map[14] = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_WRITE);
> -		protection_map[15] = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_WRITE);
> +		protection_map[0]  = __pgprot(__PC | __PP | __NX | __NR);
> +		protection_map[1]  = __pgprot(__PC | __PP | __NX | ___R);
> +		protection_map[2]  = __pgprot(__PC | __PP | __NX | __NR);
> +		protection_map[3]  = __pgprot(__PC | __PP | __NX | ___R);
> +		protection_map[4]  = __pgprot(__PC | __PP | ___R);
> +		protection_map[5]  = __pgprot(__PC | __PP | ___R);
> +		protection_map[6]  = __pgprot(__PC | __PP | ___R);
> +		protection_map[7]  = __pgprot(__PC | __PP | ___R);
> +
> +		protection_map[8]  = __pgprot(__PC | __PP | __NX | __NR);
> +		protection_map[9]  = __pgprot(__PC | __PP | __NX | ___R);
> +		protection_map[10] = __pgprot(__PC | __PP | __NX | ___W | __NR);
> +		protection_map[11] = __pgprot(__PC | __PP | __NX | ___W | ___R);
> +		protection_map[12] = __pgprot(__PC | __PP | ___R);
> +		protection_map[13] = __pgprot(__PC | __PP | ___R);
> +		protection_map[14] = __pgprot(__PC | __PP | ___W | ___R);
> +		protection_map[15] = __pgprot(__PC | __PP | ___W | ___R);

you are doing two steps in one go, so it's not obvious you are not only
using some macros, but also changing semantics. And while there are already
really long lines, please leave it that way and only do the access bit
change.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
