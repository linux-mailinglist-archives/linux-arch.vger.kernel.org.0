Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7D325EBD8
	for <lists+linux-arch@lfdr.de>; Sun,  6 Sep 2020 02:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbgIFAZn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Sep 2020 20:25:43 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:41621 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbgIFAZm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 Sep 2020 20:25:42 -0400
X-Greylist: delayed 14836 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 Sep 2020 20:25:40 EDT
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 0860PFxS024045;
        Sun, 6 Sep 2020 09:25:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 0860PFxS024045
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1599351916;
        bh=smhRM/0gS2ife7hbqoAb+BEFwkqlNArzwskfuvsPnHQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PkKiD5JBmvPt9YbEpNWvP9dwiiCW89Jxh8yssXcCWUWpb1UiehH+fUUvKRbBUgq4l
         NJCrPtXNI/frWpVZlXNTv6mMZEMn1znlMPK9PuhVRxoYkDh6FzRbF6QzW/16gc0Ed7
         xNrcNj7AFuONFKBo1X1fnr+uXevgUh6aziZQ6k5e4UsmAxnEApAHjX39hDHv4+p6NK
         mM2wmm+uIjDNeSKYE5/K0doPqcK6xo3A5DOVvw4byts7cId1xdsUtAGsY/gcBoYaYz
         ZIX1o2UPo370CPlDYibWgwRJy+49SnBTE0YDk6pSDLco5iAKe8sWTPVLgx1xJJfeV1
         cLH7W80AR9Lrw==
X-Nifty-SrcIP: [209.85.214.179]
Received: by mail-pl1-f179.google.com with SMTP id q3so953898plr.13;
        Sat, 05 Sep 2020 17:25:15 -0700 (PDT)
X-Gm-Message-State: AOAM532mF5l74CQ9UcvMu3aqjbpNsQWQYzwffAPFTFx+Kh8EZ0JHPfBE
        AAEW7qIL4wyqDhTmpwfj1mXFKeDIL210nY/LCck=
X-Google-Smtp-Source: ABdhPJxbCWrj7SAKzQnfIYweG+DVFI5qXPfBL18NWV+r08yubtSKWeb87Imal2HX3Iks4twK5ZPYbZMtYaCw68W7ffo=
X-Received: by 2002:a17:90b:360a:: with SMTP id ml10mr13696135pjb.198.1599351914954;
 Sat, 05 Sep 2020 17:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com> <20200903203053.3411268-1-samitolvanen@google.com>
In-Reply-To: <20200903203053.3411268-1-samitolvanen@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 6 Sep 2020 09:24:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNASDUkyJMDD0a5K_HT=1q5NEc6dcN4=FUb330yK0BCKcTw@mail.gmail.com>
Message-ID: <CAK7LNASDUkyJMDD0a5K_HT=1q5NEc6dcN4=FUb330yK0BCKcTw@mail.gmail.com>
Subject: Re: [PATCH v2 00/28] Add support for Clang LTO
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, X86 ML <x86@kernel.org>
Content-Type: multipart/mixed; boundary="000000000000c3236d05ae9a2200"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--000000000000c3236d05ae9a2200
Content-Type: text/plain; charset="UTF-8"

On Fri, Sep 4, 2020 at 5:30 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> This patch series adds support for building x86_64 and arm64 kernels
> with Clang's Link Time Optimization (LTO).
>
> In addition to performance, the primary motivation for LTO is
> to allow Clang's Control-Flow Integrity (CFI) to be used in the
> kernel. Google has shipped millions of Pixel devices running three
> major kernel versions with LTO+CFI since 2018.
>
> Most of the patches are build system changes for handling LLVM
> bitcode, which Clang produces with LTO instead of ELF object files,
> postponing ELF processing until a later stage, and ensuring initcall
> ordering.
>
> Note that patches 1-4 are not directly related to LTO, but are
> needed to compile LTO kernels with ToT Clang, so I'm including them
> in the series for your convenience:
>
>  - Patches 1-3 are required for building the kernel with ToT Clang,
>    and IAS, and patch 4 is needed to build allmodconfig with LTO.
>
>  - Patches 3-4 are already in linux-next, but not yet in 5.9-rc.
>


I still do not understand how this patch set works.
(only me?)

Please let me ask fundamental questions.



I applied this series on top of Linus' tree,
and compiled for ARCH=arm64.

I compared the kernel size with/without LTO.



[1] No LTO  (arm64 defconfig, CONFIG_LTO_NONE)

$ llvm-size   vmlinux
   text    data     bss     dec     hex filename
15848692 10099449 493060 26441201 19375f1 vmlinux



[2] Clang LTO  (arm64 defconfig + CONFIG_LTO_CLANG)

$ llvm-size   vmlinux
   text    data     bss     dec     hex filename
15906864 10197445 490804 26595113 195cf29 vmlinux


I compared the size of raw binary, arch/arm64/boot/Image.
Its size increased too.



So, in my experiment, enabling CONFIG_LTO_CLANG
increases the kernel size.
Is this correct?


One more thing, could you teach me
how Clang LTO optimizes the code against
relocatable objects?



When I learned Clang LTO first, I read this document:
https://llvm.org/docs/LinkTimeOptimization.html

It is easy to confirm the final executable
does not contain foo2, foo3...



In contrast to userspace programs,
kernel modules are basically relocatable objects.

Does Clang drop unused symbols from relocatable objects?
If so, how?

I implemented an example module (see the attachment),
and checked the symbols.
Nothing was dropped.

The situation is the same for build-in
because LTO is run against vmlinux.o, which is
relocatable as well.


--
Best Regards

Masahiro Yamada

--000000000000c3236d05ae9a2200
Content-Type: application/x-patch; name="0001-lto-test-module.patch"
Content-Disposition: attachment; filename="0001-lto-test-module.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_keqbde3n0>
X-Attachment-Id: f_keqbde3n0

RnJvbSBjMWRjNjQ2ZjczYmQ5NDhlZGJmMGM0YTdmMWJhYTkzZWNmOGMyMDhlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXNhaGlybyBZYW1hZGEgPG1hc2FoaXJveUBrZXJuZWwub3Jn
PgpEYXRlOiBTdW4sIDYgU2VwIDIwMjAgMDg6MTE6MzIgKzA5MDAKU3ViamVjdDogW1BBVENIXSBs
dG86IHRlc3QgbW9kdWxlCgpIZXJlIGlzIGEgZ3JlYXQgZXhhbXBsZSBmb3IgTFRPOgogIGh0dHBz
Oi8vbGx2bS5vcmcvZG9jcy9MaW5rVGltZU9wdGltaXphdGlvbi5odG1sCgpMVE8gcmVtb3ZlcyBm
b28yKCkgYW5kIGZvbzMoKSBmcm9tIHRoZSBmaW5hbCBleGVjdXRhYmxlIGZpbGUsICJtYWluIi4K
KGFuZCBmb280KCkgaXMgYWxzbyBkcm9wcGVkIGlmIHlvdSBwYXNzIC1mbHRvIHRvIG1haW4uYykK
ClRoaXMgcGF0Y2ggaW50ZWdyYXRlcyB0aGUgZXhhbXBsZSBjb2RlIGludG8gYSBrZXJuZWwgbW9k
dWxlLgoKICBhLmMgICAgICAtPiAgIGtlcm5lbC9sdG8tdGVzdC1hLmMKICBtYWluLmMgICAtPiAg
IGtlcm5lbC9sdG8tdGVzdC1tYWluLmMKCk9mIGNvdXJzZSwgSSByZXBsYWNlZCBwcmludGYoKSB3
aXRoIHByaW50aygpLgoKSSBhcHBsaWVkIHRoaXMgdGVzdCBwYXRjaCBvbiB0b3Agb2YgU2FtaSdz
IHYyOgogIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1rYnVpbGQv
bGlzdC8/c2VyaWVzPTM0MzE1MwoKSSBjb21waWxlZCBhcm02NCBkZWZjb25maWcgKyBDT05GSUdf
TFRPX0NMQU5HLgoKVGhpcyBpcyB0aGUgcmVzdWx0OgoKJCBhYXJjaDY0LWxpbnV4LWdudS1ubSBr
ZXJuZWwvbHRvLXRlc3Qua28KMDAwMDAwMDAwMDAwMDAxMCBUIGZvbzEKMDAwMDAwMDAwMDAwMDAw
MCBUIGZvbzIKMDAwMDAwMDAwMDAwMDA0YyBUIGZvbzQKMDAwMDAwMDAwMDAwMDAwMCBCIGkubGx2
bS43NzEwNjQ1NjQyMDg1NjAyODkxCjAwMDAwMDAwMDAwMDAwMDAgciBfX2tzdHJ0YWJfbHRvX3Rl
c3RfbWFpbgowMDAwMDAwMDAwMDAwMDBlIHIgX19rc3RydGFibnNfbHRvX3Rlc3RfbWFpbgowMDAw
MDAwMDAwMDAwMDAwIHIgX19rc3ltdGFiX2x0b190ZXN0X21haW4KMDAwMDAwMDAwMDAwMDA2OCBU
IGx0b190ZXN0X21haW4KMDAwMDAwMDAwMDAwMDAwMCByIF9ub3RlXzcKICAgICAgICAgICAgICAg
ICBVIHByaW50awowMDAwMDAwMDAwMDAwMDAwIFIgLnN0ci5sbHZtLjg4NzY1MDMzMjQ4NDUxMjM4
MAowMDAwMDAwMDAwMDAwMDAwIEQgX190aGlzX21vZHVsZQowMDAwMDAwMDAwMDAwMDYzIHIgX19V
TklRVUVfSURfZGVwZW5kczI1NAowMDAwMDAwMDAwMDAwMDVhIHIgX19VTklRVUVfSURfaW50cmVl
MjUzCjAwMDAwMDAwMDAwMDAwNGMgciBfX1VOSVFVRV9JRF9uYW1lMjUyCjAwMDAwMDAwMDAwMDAw
MDAgciBfX1VOSVFVRV9JRF92ZXJtYWdpYzI1MQoKTW9kdWxlcyBhcmUgcmVsb2NhdGFibGUgb2Jq
ZWN0cywgbm90IGV4ZWN1dGFibGVzLgpIb3cgY2FuIGNsYW5nIExUTyBrbm93IHVucmVhY2hhYmxl
IHN5bWJvbHMgYXJlIHJlYWxseQp1bnJlYWNoYWJsZT8KCkFjY29yZGluZyB0byB0aGUgcmVzdWx0
IGFib3ZlLCBmb28yIGlzIHJlbWFpbmluZy4KClRoZSBiZWhhdmlvciBpcyB0aGUgc2FtZSBmb3Ig
b2JqLXkgYmVjYXVzZSBMVE8gaXMgcnVuIGFnYWluc3QKdm1saW51eC5vLCB3aGljaCBpcyBhIHJl
bG9jYXRhYmxlIEVMRi4KClNpZ25lZC1vZmYtYnk6IE1hc2FoaXJvIFlhbWFkYSA8bWFzYWhpcm95
QGtlcm5lbC5vcmc+Ci0tLQoga2VybmVsL01ha2VmaWxlICAgICAgICB8ICAzICsrKwoga2VybmVs
L2x0by10ZXN0LWEuYyAgICB8IDIyICsrKysrKysrKysrKysrKysrKysrKysKIGtlcm5lbC9sdG8t
dGVzdC1hLmggICAgfCAgMyArKysKIGtlcm5lbC9sdG8tdGVzdC1tYWluLmMgfCAxMiArKysrKysr
KysrKysKIDQgZmlsZXMgY2hhbmdlZCwgNDAgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAw
NjQ0IGtlcm5lbC9sdG8tdGVzdC1hLmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCBrZXJuZWwvbHRvLXRl
c3QtYS5oCiBjcmVhdGUgbW9kZSAxMDA2NDQga2VybmVsL2x0by10ZXN0LW1haW4uYwoKZGlmZiAt
LWdpdCBhL2tlcm5lbC9NYWtlZmlsZSBiL2tlcm5lbC9NYWtlZmlsZQppbmRleCA5YTIwMDE2ZDQ5
MDAuLjIxMTEyNTFjMjA5MyAxMDA2NDQKLS0tIGEva2VybmVsL01ha2VmaWxlCisrKyBiL2tlcm5l
bC9NYWtlZmlsZQpAQCAtMTQ3LDMgKzE0Nyw2IEBAICQob2JqKS9raGVhZGVyc19kYXRhLnRhci54
ejogRk9SQ0UKIAkkKGNhbGwgY21kLGdlbmlraCkKIAogY2xlYW4tZmlsZXMgOj0ga2hlYWRlcnNf
ZGF0YS50YXIueHoga2hlYWRlcnMubWQ1CisKK29iai1tICs9IGx0by10ZXN0Lm8KK2x0by10ZXN0
LW9ianMgOj0gbHRvLXRlc3QtYS5vIGx0by10ZXN0LW1haW4ubwpkaWZmIC0tZ2l0IGEva2VybmVs
L2x0by10ZXN0LWEuYyBiL2tlcm5lbC9sdG8tdGVzdC1hLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQK
aW5kZXggMDAwMDAwMDAwMDAwLi4xNWNkYzMyMGVjMWUKLS0tIC9kZXYvbnVsbAorKysgYi9rZXJu
ZWwvbHRvLXRlc3QtYS5jCkBAIC0wLDAgKzEsMjIgQEAKKyNpbmNsdWRlICJsdG8tdGVzdC1hLmgi
CisKK3N0YXRpYyBzaWduZWQgaW50IGkgPSAwOworCit2b2lkIGZvbzIodm9pZCkgeworICBpID0g
LTE7Cit9CisKK3N0YXRpYyBpbnQgZm9vMyh2b2lkKSB7CisgIGZvbzQoKTsKKyAgcmV0dXJuIDEw
OworfQorCitpbnQgZm9vMSh2b2lkKSB7CisgIGludCBkYXRhID0gMDsKKworICBpZiAoaSA8IDAp
CisgICAgZGF0YSA9IGZvbzMoKTsKKworICBkYXRhID0gZGF0YSArIDQyOworICByZXR1cm4gZGF0
YTsKK30KZGlmZiAtLWdpdCBhL2tlcm5lbC9sdG8tdGVzdC1hLmggYi9rZXJuZWwvbHRvLXRlc3Qt
YS5oCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwMC4uZmNhNGQxM2E1MmUw
Ci0tLSAvZGV2L251bGwKKysrIGIva2VybmVsL2x0by10ZXN0LWEuaApAQCAtMCwwICsxLDMgQEAK
K2V4dGVybiBpbnQgZm9vMSh2b2lkKTsKK2V4dGVybiB2b2lkIGZvbzIodm9pZCk7CitleHRlcm4g
dm9pZCBmb280KHZvaWQpOwpkaWZmIC0tZ2l0IGEva2VybmVsL2x0by10ZXN0LW1haW4uYyBiL2tl
cm5lbC9sdG8tdGVzdC1tYWluLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAw
MDAwLi42ZThjYWEyYzc2NjcKLS0tIC9kZXYvbnVsbAorKysgYi9rZXJuZWwvbHRvLXRlc3QtbWFp
bi5jCkBAIC0wLDAgKzEsMTIgQEAKKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KKyNpbmNsdWRl
IDxsaW51eC9leHBvcnQuaD4KKyNpbmNsdWRlICJsdG8tdGVzdC1hLmgiCisKK3ZvaWQgZm9vNCh2
b2lkKSB7CisgIHByaW50aygiSGlcbiIpOworfQorCitpbnQgbHRvX3Rlc3RfbWFpbih2b2lkKSB7
CisgIHJldHVybiBmb28xKCk7Cit9CitFWFBPUlRfU1lNQk9MKGx0b190ZXN0X21haW4pOwotLSAK
Mi4yNS4xCgo=
--000000000000c3236d05ae9a2200--
