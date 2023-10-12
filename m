Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481377C6FBF
	for <lists+linux-arch@lfdr.de>; Thu, 12 Oct 2023 15:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbjJLNxO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Oct 2023 09:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjJLNxO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Oct 2023 09:53:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB579B7;
        Thu, 12 Oct 2023 06:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
        In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p6BwkcEmSmSrSpHSIri1bUfhXq/7wfBAJLSJFJQX86U=; b=Q07degRdV35/Iaxl2lvbzbefZ+
        XJ+i1Z2dZ11bG1BQ/5exDlYQtAqnatR5iMEV2COjGI+bdILudaMnjTx+MmLcfmjDcJv8H/cet+um4
        JJhreoYiUAIm632VHtyNJ4uW1kW2WTJk++QCLa8qgsnwaWJXXigEMtTTPd28lcJVou+cBw6ca1W7p
        VjtkkqsiFlquvGs9LbFPkGj+yEcN7P3Y87K0GufOZ4bF8Vmq5eKOA3jKIQvn/atemWeQvXYhuHQPQ
        tguUzI/Bf1zVox0myEeTqSsMrr/a9WBu++Bk265zBxPHDUhveI7OtILYCOJHEr+SYSMZ6J4A/G3SA
        +HXm/hTw==;
Received: from [2001:8b0:10b:5:8fd2:9e3e:cd2f:735f] (helo=u3832b3a9db3152.ant.amazon.com)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qqw7e-00HF9K-PK; Thu, 12 Oct 2023 13:53:06 +0000
Message-ID: <4c63ee3634ccfed7d687fcbdd9db60663bce481f.camel@infradead.org>
Subject: Re: [PATCH v6 06/38] mm: Add default definition of set_ptes()
From:   David Woodhouse <dwmw2@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>
Date:   Thu, 12 Oct 2023 14:53:05 +0100
In-Reply-To: <20230802151406.3735276-7-willy@infradead.org>
References: <20230802151406.3735276-1-willy@infradead.org>
         <20230802151406.3735276-7-willy@infradead.org>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
        boundary="=-a3KmwuGX4I14b0YbaVNl"
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--=-a3KmwuGX4I14b0YbaVNl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2023-08-02 at 16:13 +0100, Matthew Wilcox (Oracle) wrote:
> Most architectures can just define set_pte() and PFN_PTE_SHIFT to
> use this definition.=C2=A0 It's also a handy spot to document the guarant=
ees
> provided by the MM.
>=20
> Suggested-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
> =C2=A0include/linux/pgtable.h | 81 ++++++++++++++++++++++++++++++--------=
---
> =C2=A01 file changed, 60 insertions(+), 21 deletions(-)
>=20
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index f34e0f2cb4d8..3fde0d5d1c29 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -182,6 +182,66 @@ static inline int pmd_young(pmd_t pmd)
> =C2=A0}
> =C2=A0#endif
> =C2=A0
> +/*
> + * A facility to provide lazy MMU batching.=C2=A0 This allows PTE update=
s and
> + * page invalidations to be delayed until a call to leave lazy MMU mode
> + * is issued.=C2=A0 Some architectures may benefit from doing this, and =
it is
> + * beneficial for both shadow and direct mode hypervisors, which may bat=
ch
> + * the PTE updates which happen during this window.=C2=A0 Note that usin=
g this
> + * interface requires that read hazards be removed from the code.=C2=A0 =
A read
> + * hazard could result in the direct mode hypervisor case, since the act=
ual
> + * write to the page tables may not yet have taken place, so reads thoug=
h
> + * a raw PTE pointer after it has been modified are not guaranteed to be
> + * up to date.=C2=A0 This mode can only be entered and left under the pr=
otection of
> + * the page table locks for all page tables which may be modified.=C2=A0=
 In the UP
> + * case, this is required so that preemption is disabled, and in the SMP=
 case,
> + * it must synchronize the delayed page table writes properly on other C=
PUs.
> + */
> +#ifndef __HAVE_ARCH_ENTER_LAZY_MMU_MODE
> +#define arch_enter_lazy_mmu_mode()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0do {} wh=
ile (0)
> +#define arch_leave_lazy_mmu_mode()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0do {} wh=
ile (0)
> +#define arch_flush_lazy_mmu_mode()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0do {} wh=
ile (0)
> +#endif
> +
> +#ifndef set_ptes
> +#ifdef PFN_PTE_SHIFT
> +/**
> + * set_ptes - Map consecutive pages to a contiguous range of addresses.
> + * @mm: Address space to map the pages into.
> + * @addr: Address to map the first page at.
> + * @ptep: Page table pointer for the first entry.
> + * @pte: Page table entry for the first page.
> + * @nr: Number of pages to map.
> + *
> + * May be overridden by the architecture, or the architecture can define
> + * set_pte() and PFN_PTE_SHIFT.
> + *
> + * Context: The caller holds the page table lock.=C2=A0 The pages all be=
long
> + * to the same folio.=C2=A0 The PTEs are all in the same PMD.
> + */
> +static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0pte_t *ptep, pte_t pte, unsigned int nr)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0page_table_check_ptes_set(mm, =
ptep, pte, nr);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0arch_enter_lazy_mmu_mode();
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (;;) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0set_pte(ptep, pte);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0if (--nr =3D=3D 0)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0ptep++;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0pte =3D __pte(pte_val(pte) + (1UL << PFN_PTE_SHIFT));
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0arch_leave_lazy_mmu_mode();
> +}


This breaks the Xen PV guest.

In move_ptes() in mm/mremap.c we arch_enter_lazy_mmu_mode() and then
loop calling set_pte_at(). Which now (or at least in a few commits time
when you wire it up for x86 in commit a3e1c9372c9b959) ends up in your
implementation of set_ptes(), calls arch_enter_lazy_mmu_mode() again,
and:

[    0.628700] ------------[ cut here ]------------
[    0.628718] kernel BUG at arch/x86/kernel/paravirt.c:144!
[    0.628743] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[    0.628769] CPU: 0 PID: 1 Comm: init Not tainted 6.5.0-rc4+ #1295
[    0.628818] RIP: e030:paravirt_enter_lazy_mmu+0x24/0x30
[    0.628839] Code: 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 65 8b 05 =
90 28 f9 7e 85 c0 75 10 65 c7 05 81 28 f9 7e 01 00 00 00 c3 cc cc cc cc <0f=
> 0b 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90
[    0.628875] RSP: e02b:ffffc9004000ba48 EFLAGS: 00010202
[    0.628891] RAX: 0000000000000001 RBX: ffff8880051b7100 RCX: 000ffffffff=
ff000
[    0.628908] RDX: 80000000763ff967 RSI: 80000000763ff967 RDI: ffff8880051=
b7100
[    0.628925] RBP: 80000000763ff967 R08: ffff8880051b6868 R09: 00007ffce1a=
20000
[    0.628943] R10: deadbeefdeadf00d R11: 0000000000000000 R12: 00007ffffff=
ff000
[    0.628964] R13: ffff8880050b7000 R14: 0000000000000001 R15: 00007ffffff=
fe000
[    0.628988] FS:  0000000000000000(0000) GS:ffff88807b800000(0000) knlGS:=
0000000000000000
[    0.629007] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.629024] CR2: ffffc900003f5000 CR3: 0000000003904000 CR4: 00000000000=
50660
[    0.629046] Call Trace:
[    0.629055]  <TASK>
[    0.629066]  ? die+0x36/0x90
[    0.629081]  ? do_trap+0xda/0x100
[    0.629093]  ? paravirt_enter_lazy_mmu+0x24/0x30
[    0.629112]  ? do_error_trap+0x6a/0x90
[    0.629123]  ? paravirt_enter_lazy_mmu+0x24/0x30
[    0.629138]  ? exc_invalid_op+0x50/0x70
[    0.629155]  ? paravirt_enter_lazy_mmu+0x24/0x30
[    0.629169]  ? asm_exc_invalid_op+0x1a/0x20
[    0.629185]  ? paravirt_enter_lazy_mmu+0x24/0x30
[    0.629212]  ? pte_offset_map_nolock+0x48/0xc0
[    0.629226]  set_ptes.constprop.0+0xd/0x30
[    0.629240]  move_ptes.isra.0+0xdd/0x290
[    0.629253]  ? pmd_install+0xab/0xd0
[    0.629267]  move_page_tables+0x3a0/0x850
[    0.629294]  shift_arg_pages+0xf4/0x1d0
[    0.629317]  setup_arg_pages+0x205/0x380
[    0.629330]  load_elf_binary+0x398/0xe00


I'm working on making PV kernels testable in qemu. With...

 =E2=80=A2 some qemu fixes and a nasty hackish Xen console implementation:
   https://git.infradead.org/users/dwmw2/qemu.git/shortlog/refs/heads/xenfv=
-console
 =E2=80=A2 a CONFIG_PV_SHIM_EXCLUSIVE build of Xen itself to run in the gue=
st,
 =E2=80=A2 some suitable disk image lying around, in ${GUEST_IMAGE}, and
 =E2=80=A2 CONFIG_KVM_XEN enabled in your host kernel,

...you should be able to do something like:

 $ ./qemu-system-x86_64 --accel kvm,xen-version=3D0x40011,kernel-irqchip=3D=
split -drive file=3D${GUEST_IMAGE},if=3Dnone,id=3Ddisk -device xen-disk,dri=
ve=3Ddisk,vdev=3Dxvda -m 1G -kernel ~/git/xen/xen/xen -initrd ~/git/linux/a=
rch/x86/boot/bzImage -append "loglvl=3Dall -- console=3Dhvc0 root=3D/dev/xv=
da1" -display none






--=-a3KmwuGX4I14b0YbaVNl
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEkQw
ggYQMIID+KADAgECAhBNlCwQ1DvglAnFgS06KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0xODExMDIwMDAwMDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYD
VQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAyjztlApB/975Rrno1jvm2pK/KxBOqhq8gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUf
ItMltrMaXqcESJuK8dtK56NCSrq4iDKaKq9NxOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeW
QcpGEGFUUd0kN+oHox+L9aV1rjfNiCj3bJk6kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YB
rf24k5Ee1sLTHsLtpiK9OjG4iQRBdq6Z/TlVx/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewD
ch/8kHPo5fZl5u1B0ecpq/sDN/5sCG52Ds+QU5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAU
U3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEF
BQcDBDARBgNVHSAECjAIMAYGBFUdIAAwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2Vy
dHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUF
BwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJT
QUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0G
CSqGSIb3DQEBDAUAA4ICAQBBRHUAqznCFfXejpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+
xswhh2GqkW5JQrM8zVlU+A2VP72Ky2nlRA1GwmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9
IHk96VwsacIvBF8JfqIs+8aWH2PfSUrNxP6Ys7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7
kkmka2RQb9d90nmNHdgKrwfQ49mQ2hWQNDkJJIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1
eoYV7lNwNBKpeHdNuO6Aacb533JlfeUHxvBz9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4
KxaYIhvqPqUMWqRdWyn7crItNkZeroXaecG03i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL
1Ygz3SBsyECa0waq4hOf/Z85F2w2ZpXfP+w8q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQ
OZ1YL5ezMTX0ZSLwrymUE0pwi/KDaiYB15uswgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qod
x/PL+5jR87myx5uYdBEQkkDc+lKB1Wct6ucXqm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i
5ZgtwCLXgAIe5W8mybM2JzCCBhQwggT8oAMCAQICEQDGvhmWZ0DEAx0oURL6O6l+MA0GCSqGSIb3
DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
VQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28g
UlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIyMDEwNzAw
MDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9y
ZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3GpC2bomUqk+91wLYBzDMcCj5C9m6
oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZHh7htyAkWYVoFsFPrwHounto8xTsy
SSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT9YgcBqKCo65pTFmOnR/VVbjJk4K2
xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNjP+qDrh0db7PAjO1D4d5ftfrsf+kd
RR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy2U+eITZ5LLE5s45mX2oPFknWqxBo
bQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3BgBEmfsYWlBXO8rVXfvPgLs32VdV
NZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/7auNVRmPB3v5SWEsH8xi4Bez2V9U
KxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmdlFYhAflWKQ03Ufiu8t3iBE3VJbc2
5oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9aelIl6vtbhMA+l0nfrsORMa4kobqQ5
C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMBAAGjggHMMIIByDAfBgNVHSMEGDAW
gBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeDMcimo0oz8o1R1Nver3ZVpSkwDgYD
VR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGln
by5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGln
b1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYoGCCsGAQUFBwEB
BH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50
QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEFBQcwAYYXaHR0cDovL29j
c3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5mcmFkZWFkLm9yZzANBgkqhkiG9w0B
AQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQvQ/fzPXmtR9t54rpmI2TfyvcKgOXp
qa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvIlSPrzIB4Z2wyIGQpaPLlYflrrVFK
v9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9ChWFfgSXvrWDZspnU3Gjw/rMHrGnql
Htlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0whpBtXdyDjzBtQTaZJ7zTT/vlehc/
tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9IzCCBhQwggT8oAMCAQICEQDGvhmW
Z0DEAx0oURL6O6l+MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3Jl
YXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0
ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJl
IEVtYWlsIENBMB4XDTIyMDEwNzAwMDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJ
ARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3
GpC2bomUqk+91wLYBzDMcCj5C9m6oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZH
h7htyAkWYVoFsFPrwHounto8xTsySSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT
9YgcBqKCo65pTFmOnR/VVbjJk4K2xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNj
P+qDrh0db7PAjO1D4d5ftfrsf+kdRR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy
2U+eITZ5LLE5s45mX2oPFknWqxBobQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3
BgBEmfsYWlBXO8rVXfvPgLs32VdVNZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/
7auNVRmPB3v5SWEsH8xi4Bez2V9UKxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmd
lFYhAflWKQ03Ufiu8t3iBE3VJbc25oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9ae
lIl6vtbhMA+l0nfrsORMa4kobqQ5C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMB
AAGjggHMMIIByDAfBgNVHSMEGDAWgBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeD
Mcimo0oz8o1R1Nver3ZVpSkwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYw
FAYIKwYBBQUHAwQGCCsGAQUFBwMCMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYB
BQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9j
cmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1h
aWxDQS5jcmwwgYoGCCsGAQUFBwEBBH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdv
LmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAj
BggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5m
cmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQv
Q/fzPXmtR9t54rpmI2TfyvcKgOXpqa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvI
lSPrzIB4Z2wyIGQpaPLlYflrrVFKv9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9Ch
WFfgSXvrWDZspnU3Gjw/rMHrGnqlHtlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0w
hpBtXdyDjzBtQTaZJ7zTT/vlehc/tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9
IzGCBMcwggTDAgEBMIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVz
dGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMT
NVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA
xr4ZlmdAxAMdKFES+jupfjANBglghkgBZQMEAgEFAKCCAeswGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjMxMDEyMTM1MzA1WjAvBgkqhkiG9w0BCQQxIgQgW5uc5IJb
EPdxRgNcp1eTi5kGvLzRnKMBfgc0eo/td/gwgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgArorcPaAMrHiU3s+6gmNh1a4j9uYn2lscJ
jp/NY26zHwg5B3TirmaqSoNfaAjIju+xwFH+sMU7Q34CDlHyNmQZxyC95viWugNjkl2Uyy+DyzIn
77TH1d6OXQla4IqKbBE6rS9ZXGC/Dqw/gwe7czmgbBVwhmdBI1SxCK9zmuwm+6BIjiH1Q5ZvXVgL
VbT0I8ll+EXce4tol4KpIepk0GyPeYYLWrXAZkNMUjfZGhvXAyTV+vDL5NJOHgv0z1oUtjs5p60h
JS2a0fUwUAT3x1inykJsDE5YIbQAp42yu7mYlyIyBlhDV20CkjCAxNDznSITSf10oReU1Edz6jYq
2PtpQD7DyPWd6Ohv2leWc/Zek/tPTzAjHw26n5r/77CMRE1Qv8lGgxirMT7yQX8doQW9BFOcwahy
mJhWmenhfv/jiL4jZnLZDg0528Zhr0tF3hj1/QzNvKtdJL25+Ig/FOS+vVx6eL+9qhOKm0GYjXbN
UYIlZgXZjnpyFflaVRIRiLsAAoGaNaVbDDOsxFDam4gaN1eVIA9nlPtHvvTqFkJM0v+Er8yrPi5o
XhoH+K2iQ69XPnPLuRhbRVoe4K2DxGcGikP7Bpe/F2ddlJqIx/+KoA8umPuXLUxp1f6xVRwKXnGo
I/cNo9J1biBVw8aAZ3XBglakENjEMIxcZ1G0Qq9yuAAAAAAAAA==


--=-a3KmwuGX4I14b0YbaVNl--
