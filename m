Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A841CD1E9
	for <lists+linux-arch@lfdr.de>; Mon, 11 May 2020 08:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgEKGgm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 May 2020 02:36:42 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:43674 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgEKGgm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 May 2020 02:36:42 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200511063638euoutp01c57bd6441776556f1eac33bdc814ffbf~N5eET4WlF0043800438euoutp01s;
        Mon, 11 May 2020 06:36:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200511063638euoutp01c57bd6441776556f1eac33bdc814ffbf~N5eET4WlF0043800438euoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1589178998;
        bh=Ylr6oV5MTHitaD4ecDqT3Dgf/oTl0b2za1BVdOaEwhg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=kd1vHxMyMbSphShD1GqPxYSauOVcX0Jx7wY6xJhk8l2ndBxZjk24SBs0LnqWvzKZz
         NsPOHne3EUemdluWTFiHVb+vzSJJYkEygdxq4YBfQuy/84+Xi8wtT2mA63f9lOsgbB
         0TaEBMrgYr24Rz7bKAwQy2NAyTWXOiow3331pee4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200511063638eucas1p29157fbb6a6d0cf5feb48353886bea8df~N5eED5sxz3213332133eucas1p2L;
        Mon, 11 May 2020 06:36:38 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id B9.33.61286.672F8BE5; Mon, 11
        May 2020 07:36:38 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200511063637eucas1p2001793c8e2aeb5ab9d4bdd904cb30cfc~N5eDuTDR20092100921eucas1p2R;
        Mon, 11 May 2020 06:36:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200511063637eusmtrp152e12d3489d98a4e2450a1a454ab80a0~N5eDtHgIB1171311713eusmtrp1S;
        Mon, 11 May 2020 06:36:37 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-cc-5eb8f2769a9a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D1.34.07950.572F8BE5; Mon, 11
        May 2020 07:36:37 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200511063635eusmtip1b4af72cc5b63a7e71b083ad27fce7cf0~N5eB_XIQv0294902949eusmtip1e;
        Mon, 11 May 2020 06:36:35 +0000 (GMT)
Subject: Re: [PATCH v4 02/14] arm: add support for folded p4d page tables
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-sh@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
        linux-hexagon@vger.kernel.org, Will Deacon <will@kernel.org>,
        kvmarm@lists.cs.columbia.edu, Jonas Bonn <jonas@southpole.se>,
        linux-arch@vger.kernel.org, Brian Cain <bcain@codeaurora.org>,
        Marc Zyngier <maz@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        uclinux-h8-devel@lists.sourceforge.jp,
        Fenghua Yu <fenghua.yu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, kvm-ppc@vger.kernel.org,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org, Stafford Horne <shorne@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>,
        linux-arm-kernel@lists.infradead.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Tony Luck <tony.luck@intel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        nios2-dev@lists.rocketboards.org, linuxppc-dev@lists.ozlabs.org,
        =?UTF-8?Q?=c5=81ukasz_Stelmach?= <l.stelmach@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <665dade8-727a-3318-6779-3998080da18f@samsung.com>
Date:   Mon, 11 May 2020 08:36:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200508174232.GA759899@linux.ibm.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02TbUxTZxTH89y3XpqVXCuOR0fc1jgSZ8Q1m8lZXNic+3D1w+KSxQ/Gt27e
        IRkU1woDP7hCC4GmbtrhrIX5AoKAHZ0FtKB1rHPUloiMJgQ3LTo0sQTWWkaQFnC3vTj59jvn
        /M/zP/8PD0sqZ5lVbL72kKDTagpUjJy63Dd7e31JzL3nrce9JNQ7HQzMW/tkcMnmpKG7coSC
        aEUlCZFmC4JqIwHnZuM0VP2wGX6ssyKY91xiYO5UlICJ2Dp4EvDJ4I63BcHo1XJR3jNNgWts
        mIaIyc1AtPofGoI99QyEHM9oqJ+rJcF7woMgMbMgWtX7aeg0eBkw2x8x4KoJMuC40SiDG84r
        BIzUGhjwnLiP4JarVTQbDFHQ1R8hwXR3I4xaPcQH2bzjtAPxweE/SD4RtyK+8runDB/89ijB
        N4QNFH/81nq+235PxjdeCxO8ZcJE8662GoZ3xawyfqAuSvE3bQmKP9bQi/jbLge5PWun/L39
        QkF+iaDbkLtPfiDYeZU+6F5ZavutnTIg5wozSmMx9w7uCPvJJCu5FoTH5jdJ/C/ChnNfmZFc
        5CmEawLXZc8XZlrjtDS4gHDQeZGSigjC7acfUEnVcm4rPtrxe4ozuGxcMW0nkiKSeyzHhrmb
        KT+GU2PzpJlJsoLLxVXhuRRT3Bv4jqcbJXkFtxv3N3YgSbMM+089TD2aJp4RCbSkmORexcau
        OlLiTPznwzMpM8wNp+Hmmmkk3f0RHnTWLvJyPO7rXMyThfu/t1DSghHhBwM/yaTCIoarsC1u
        bMJ3B+LieaxosRY7ezZI7c34ZOQKkWxjLh2PTC6TjkjH1ssnSamtwNVVSkmdje2+9v9tfx0c
        Io8hlX1JNPuSOPYlcewvfM8iqg1lCsX6wjxBr9YKX+foNYX6Ym1ezudFhS4kfoj+BV/MjaaH
        PvMijkWqlxTbX3PvUdKaEn1ZoRdhllRlKPiQ2FLs15QdFnRFe3XFBYLei15hKVWm4u2G8G4l
        l6c5JHwpCAcF3fMpwaatMiCjtuliaeLva7+sGfdkFWfsMB4+Ip8fLbPtjSwEdplireqdE59O
        zbz7+jb//W3jTV806bo6rab2uEe2MTr6JPQhtpTnGm0r6ZyP7wX+agucYfH193tC59fl7+iy
        lqrP++mn5dG1vZbVPw9t+cZXF0mfKtq1tbni2di+BHb0vTz5Cago/QGN+k1Sp9f8B4MG/RkM
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTVxzHPffVC7PJXYVwRkzU+sq2WFcQ+2NxRI2bx7gsRrN/cIoNXh6x
        pay3JUqWrAqY2oBio6SWik6CQW1ELziKWB/VwYDAMI1EdMLcWLIq8uhikIe40rqE/z45v+/n
        fM9JfjytquCS+fwCi2gu0BvUXDzTNdv+bI017Nv7WcXD1eBp8HLw1tmmgOuuBhZayh4zMHak
        jIbRi+UI7CUU/DQ5xcLRqk1wttqJ4K3/OgczZ8YoGA5/CuOd7QroD9QjGGw9HInffM2A/Fcf
        C6OlPg7G7CMsBG96OBjwvmPBM3OKhsBpP4LpidlIlaeDhSZbgAOH+28O5GNBDrwPahXwoKGZ
        gsenbBz4T/+BoFu+FCnrHWDgRtcoDaW/p8Gg009tXEW8NV5Egn0PaTI95USk7MQbjgSPV1Dk
        QsjGkJPda0iL+5mC1N4KUaR8uJQl8uVjHJHDTgXpqR5jyK+uaYZUXriLyG+yl96xOFOzwWyy
        WsSleSbJ8oV6txZSNNp00KSsS9doU3V7Pk9JU6/N2LBfNOQXiea1Gfs0ecGmVrbQ99FB1/2r
        jA01JDpQHI+FdXji0hTrQPG8SqhDeLK1m4sNFuOOKhsb40V4ps/BxUKvEJab71Fzg0XCNlzR
        +AszxwnCKnzktZuaC9HCi3hcf87z3hincO+13ui1nKDFjleOKCuFDHw0NBNlRliJ+/0taI4T
        hT34Sl8ZimU+xB1nhqINcZG3jnbWR5kW1uOaxud0jJfgkhvV7zkJPxk6R1UilXue7p6nuOcp
        7nnKecRcRgmiVTLmGqUUjaQ3StaCXE22ySijyCr+3DbZ5EOOkV0BJPBIvVC5Y6lvr4rVF0mH
        jAGEeVqdoCQDkSPlfv2hYtFsyjJbDaIUQGmRz52kkxOzTZHFLrBkadO0OkjX6lJ1qetBnaS0
        C/e+Uwm5eot4QBQLRfP/HsXHJdvQicGO4KPlO7mhLYbOpCfbQhM/uP6M/yDnjenLTrVu5T/F
        Pbf6/11Qm+UamZ5qDc4OZz7KP/t1UWXO/fDBcsPz7eeDOWLx0123M37ku5YRua7m480rvl+9
        s3F7b9Ude3rhu5CN/0ZTp3uZ/dW3zfaRcPZxx9bDmQd6atqfliy5eme8sO22mpHy9NpPaLOk
        /w+fr36koAMAAA==
X-CMS-MailID: 20200511063637eucas1p2001793c8e2aeb5ab9d4bdd904cb30cfc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200507121658eucas1p240cf4a3e0fe5c22dda5ec4f72734149f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200507121658eucas1p240cf4a3e0fe5c22dda5ec4f72734149f
References: <20200414153455.21744-1-rppt@kernel.org>
        <20200414153455.21744-3-rppt@kernel.org>
        <CGME20200507121658eucas1p240cf4a3e0fe5c22dda5ec4f72734149f@eucas1p2.samsung.com>
        <39ba8a04-d6b5-649d-c289-0c8b27cb66c5@samsung.com>
        <20200507161155.GE683243@linux.ibm.com>
        <98229ab1-fbf8-0a89-c5d6-270c828799e7@samsung.com>
        <20200508174232.GA759899@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Mike,

On 08.05.2020 19:42, Mike Rapoport wrote:
> On Fri, May 08, 2020 at 08:53:27AM +0200, Marek Szyprowski wrote:
>> On 07.05.2020 18:11, Mike Rapoport wrote:
>>> On Thu, May 07, 2020 at 02:16:56PM +0200, Marek Szyprowski wrote:
>>>> On 14.04.2020 17:34, Mike Rapoport wrote:
>>>>> From: Mike Rapoport <rppt@linux.ibm.com>
>>>>>
>>>>> Implement primitives necessary for the 4th level folding, add walks of p4d
>>>>> level where appropriate, and remove __ARCH_USE_5LEVEL_HACK.
>>>>>
>>>>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>>>> Today I've noticed that kexec is broken on ARM 32bit. Bisecting between
>>>> current linux-next and v5.7-rc1 pointed to this commit. I've tested this
>>>> on Odroid XU4 and Raspberry Pi4 boards. Here is the relevant log:
>>>>
>>>> # kexec --kexec-syscall -l zImage --append "$(cat /proc/cmdline)"
>>>> memory_range[0]:0x40000000..0xbe9fffff
>>>> memory_range[0]:0x40000000..0xbe9fffff
>>>> # kexec -e
>>>> kexec_core: Starting new kernel
>>>> 8<--- cut here ---
>>>> Unable to handle kernel paging request at virtual address c010f1f4
>>>> pgd = c6817793
>>>> [c010f1f4] *pgd=4000041e(bad)
>>>> Internal error: Oops: 80d [#1] PREEMPT ARM
>>>> Modules linked in:
>>>> CPU: 0 PID: 1329 Comm: kexec Tainted: G        W
>>>> 5.7.0-rc3-00127-g6cba81ed0f62 #611
>>>> Hardware name: Samsung Exynos (Flattened Device Tree)
>>>> PC is at machine_kexec+0x40/0xfc
>>> Any chance you have the debug info in this kernel?
>>> scripts/faddr2line would come handy here.
>> # ./scripts/faddr2line --list vmlinux machine_kexec+0x40
>> machine_kexec+0x40/0xf8:
>>
>> machine_kexec at arch/arm/kernel/machine_kexec.c:182
>>    177            reboot_code_buffer =
>> page_address(image->control_code_page);
>>    178
>>    179            /* Prepare parameters for reboot_code_buffer*/
>>    180            set_kernel_text_rw();
>>    181            kexec_start_address = image->start;
>>   >182<           kexec_indirection_page = page_list;
>>    183            kexec_mach_type = machine_arch_type;
>>    184            kexec_boot_atags = image->arch.kernel_r2;
>>    185
>>    186            /* copy our kernel relocation code to the control code
>> page */
>>    187            reboot_entry = fncpy(reboot_code_buffer,
> Can you please try the patch below:
>
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 963b5284d284..f86b3d17928e 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -571,7 +571,7 @@ static inline void section_update(unsigned long addr, pmdval_t mask,
>   {
>   	pmd_t *pmd;
>   
> -	pmd = pmd_off_k(addr);
> +	pmd = pmd_offset(pud_offset(p4d_offset(pgd_offset(mm, addr), addr), addr), addr);
>   
>   #ifdef CONFIG_ARM_LPAE
>   	pmd[0] = __pmd((pmd_val(pmd[0]) & mask) | prot);
This fixes kexec issue! Thanks!


Feel free to add:

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: 218f1c390557 ("arm: add support for folded p4d page tables")
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

