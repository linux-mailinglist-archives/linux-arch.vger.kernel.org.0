Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC9B3AD607
	for <lists+linux-arch@lfdr.de>; Sat, 19 Jun 2021 01:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbhFRXku (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Jun 2021 19:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbhFRXkr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jun 2021 19:40:47 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CF6C06175F
        for <linux-arch@vger.kernel.org>; Fri, 18 Jun 2021 16:38:37 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id z22so16143880ljh.8
        for <linux-arch@vger.kernel.org>; Fri, 18 Jun 2021 16:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ujt0YFj8hCleBj1qUWlgm6vNHZj2LMPMME1YhDe0nZY=;
        b=My/DkqJdYHkPzYwQ9/QwlnmhP+jKxsnJQnQCeWVxTD+p4MXl+Ih/bkooC3DHfyO8b5
         jAHqY5iMRQdRl0AAC6j1xhDeP606qXOB7Vz4n6FI0WnfQXatVJhb6BCPO917L4hWtpS3
         mHhhjsPbI7MQp4/FXCi1Uy0UFsLFB4nYabQpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ujt0YFj8hCleBj1qUWlgm6vNHZj2LMPMME1YhDe0nZY=;
        b=TyKE5NfJwphdB3zwamXuqDMDAvHewMTx1Ra3z1bGgybQdC6W1WUzjfWD3G+xbEnUYX
         gQh3cEOe72iwhQVlpuhfL9gI1e8zp8cUOFThUbwQvpCBDIXLJ6/lxUcCuBfIe8HPxzvQ
         BE0LauVoWJpKxx+R1OAAGD/oM4w0EVMlUkrAUk5Sc9wnRjK4Nek8xBF26ZyyAtOH4H/i
         Tbd60YFEcBD5RBNvG8eCGrBpvA+Tk5kuNgBMP37qHdqeyfCN4I7w7eskTYXDY3somiuQ
         Pg2hVUmR79VgEU6XGkrFW4Ld5OZxtG47TJsruUHoWBIa+7gpECFHmzI4UPzzYVTNHqa+
         uzxA==
X-Gm-Message-State: AOAM533azmXzTLPO1vrmFweveOx8huTuW32KzEvBLWokAWJnoR/oFQr8
        ke5Ua4vBkhQH910fuxbyLVT7Zcdm1g5H82x1
X-Google-Smtp-Source: ABdhPJxvZR0xQVFDP2SbKhQgcl4bZMqEK7KjUh5EbKtQV+nXQQfQH1goyOxy42XxotAStJGxi/YlYA==
X-Received: by 2002:a2e:9d47:: with SMTP id y7mr11232588ljj.293.1624059515508;
        Fri, 18 Jun 2021 16:38:35 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id g28sm1045794lfv.142.2021.06.18.16.38.34
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 16:38:34 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id c11so16174625ljd.6
        for <linux-arch@vger.kernel.org>; Fri, 18 Jun 2021 16:38:34 -0700 (PDT)
X-Received: by 2002:a2e:a549:: with SMTP id e9mr11202875ljn.411.1624059513842;
 Fri, 18 Jun 2021 16:38:33 -0700 (PDT)
MIME-Version: 1.0
References: <1623979642-14983-1-git-send-email-schmitzmic@gmail.com>
 <CAHk-=whTKf6UFr6YneXsPU4=8dTs+eEX_861ugESTE3CmZtFUg@mail.gmail.com> <91865b90-c597-6119-5e14-dfe521a33489@gmail.com>
In-Reply-To: <91865b90-c597-6119-5e14-dfe521a33489@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Jun 2021 16:38:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=whjJappNkdsrmsRoA4QUiu0_NNqa9Y_ct0A21m2XT5+YA@mail.gmail.com>
Message-ID: <CAHk-=whjJappNkdsrmsRoA4QUiu0_NNqa9Y_ct0A21m2XT5+YA@mail.gmail.com>
Subject: Re: [PATCH v2] m68k: save extra registers on more syscall entry points
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Content-Type: multipart/mixed; boundary="0000000000006afafd05c512d221"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--0000000000006afafd05c512d221
Content-Type: text/plain; charset="UTF-8"

On Fri, Jun 18, 2021 at 3:34 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
>
> Is your patch to copy_thread() to add the extra stack frame still needed?

So it's been a long time since I did any m68k assembly, but I think
the m68k patch for the PF_IO_WORKER thread case should look something
like the attached.

Note: my only m68k work was ever on the 68008, and used the Motorola
syntax, not the odd Sun assembler syntax, so my m68k asm skills really
aren't good.

Put another way: I'd be surprised if the attached patch actually
works, but I think it's fairly close. I tried to add comments to
explain the code at least a bit.

Hmm?

         Linus

--0000000000006afafd05c512d221
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_kq2z3aoc0>
X-Attachment-Id: f_kq2z3aoc0

IGFyY2gvbTY4ay9rZXJuZWwvZW50cnkuUyAgIHwgMTAgKysrKysrKysrKwogYXJjaC9tNjhrL2tl
cm5lbC9wcm9jZXNzLmMgfCAxNCArKysrKysrKystLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCAxOSBp
bnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvbTY4ay9rZXJu
ZWwvZW50cnkuUyBiL2FyY2gvbTY4ay9rZXJuZWwvZW50cnkuUwppbmRleCA5ZGQ3NmZiYjdjNmIu
LjQ5OWYxNGQ3OTY0MCAxMDA2NDQKLS0tIGEvYXJjaC9tNjhrL2tlcm5lbC9lbnRyeS5TCisrKyBi
L2FyY2gvbTY4ay9rZXJuZWwvZW50cnkuUwpAQCAtMTE5LDYgKzExOSwxNSBAQCBFTlRSWShyZXRf
ZnJvbV9mb3JrKQogCWFkZHFsCSM0LCVzcAogCWpyYQlyZXRfZnJvbV9leGNlcHRpb24KIAorCXwg
QSBrZXJuZWwgdGhyZWFkIHdpbGwganVtcCBoZXJlIGRpcmVjdGx5IGZyb20gcmVzdW1lLAorCXwg
d2l0aCB0aGUgc3RhY2sgY29udGFpbmluZyB0aGUgZnVsbCByZWdpc3RlciBzdGF0ZQorCXwgKHB0
X3JlZ3MgYW5kIHN3aXRjaF9zdGFjaykuCisJfAorCXwgVGhlIGFyZ3VtZW50IHdpbGwgYmUgaW4g
ZDcsIGFuZCB0aGUga2VybmVsIGZ1bmN0aW9uCisJfCB0byBjYWxsIHdpbGwgYmUgaW4gYTMuCisJ
fAorCXwgSWYgdGhlIGtlcm5lbCBmdW5jdGlvbiByZXR1cm5zLCB3ZSB3YW50IHRvIHJldHVybgor
CXwgdG8gdXNlciBzcGFjZSAtIGl0IGhhcyBkb25lIGEga2VybmVsX2V4ZWN2ZSgpLgogRU5UUlko
cmV0X2Zyb21fa2VybmVsX3RocmVhZCkKIAl8IGEzIGNvbnRhaW5zIHRoZSBrZXJuZWwgdGhyZWFk
IHBheWxvYWQsIGQ3IC0gaXRzIGFyZ3VtZW50CiAJbW92ZWwJJWQxLCVzcEAtCkBAIC0xMjYsNiAr
MTM1LDcgQEAgRU5UUlkocmV0X2Zyb21fa2VybmVsX3RocmVhZCkKIAltb3ZlbAklZDcsKCVzcCkK
IAlqc3IJJWEzQAogCWFkZHFsCSM0LCVzcAorCVJFU1RPUkVfU1dJVENIX1NUQUNLCiAJanJhCXJl
dF9mcm9tX2V4Y2VwdGlvbgogCiAjaWYgZGVmaW5lZChDT05GSUdfQ09MREZJUkUpIHx8ICFkZWZp
bmVkKENPTkZJR19NTVUpCmRpZmYgLS1naXQgYS9hcmNoL202OGsva2VybmVsL3Byb2Nlc3MuYyBi
L2FyY2gvbTY4ay9rZXJuZWwvcHJvY2Vzcy5jCmluZGV4IGRhODNjYzgzZTc5MS4uMDcwNWYxNDg3
MWEzIDEwMDY0NAotLS0gYS9hcmNoL202OGsva2VybmVsL3Byb2Nlc3MuYworKysgYi9hcmNoL202
OGsva2VybmVsL3Byb2Nlc3MuYwpAQCAtMTU4LDEzICsxNTgsMTcgQEAgaW50IGNvcHlfdGhyZWFk
KHVuc2lnbmVkIGxvbmcgY2xvbmVfZmxhZ3MsIHVuc2lnbmVkIGxvbmcgdXNwLCB1bnNpZ25lZCBs
b25nIGFyZywKIAlwLT50aHJlYWQuZnMgPSBnZXRfZnMoKS5zZWc7CiAKIAlpZiAodW5saWtlbHko
cC0+ZmxhZ3MgJiAoUEZfS1RIUkVBRCB8IFBGX0lPX1dPUktFUikpKSB7Ci0JCS8qIGtlcm5lbCB0
aHJlYWQgKi8KLQkJbWVtc2V0KGZyYW1lLCAwLCBzaXplb2Yoc3RydWN0IGZvcmtfZnJhbWUpKTsK
KwkJc3RydWN0IHN3aXRjaF9zdGFjayAqa3N0cCA9ICZmcmFtZS0+c3cgLSAxOworCisJCS8qIGtl
cm5lbCB0aHJlYWQgLSBhIGtlcm5lbC1zaWRlIHN3aXRjaC1zdGFjayBhbmQgdGhlIGZ1bGwgdXNl
ciBmb3JrX2ZyYW1lICovCisJCW1lbXNldChrc3RwLCAwLCBzaXplb2Yoc3RydWN0IHN3aXRjaF9z
dGFjaykgKyBzaXplb2Yoc3RydWN0IGZvcmtfZnJhbWUpKTsKKwogCQlmcmFtZS0+cmVncy5zciA9
IFBTX1M7Ci0JCWZyYW1lLT5zdy5hMyA9IHVzcDsgLyogZnVuY3Rpb24gKi8KLQkJZnJhbWUtPnN3
LmQ3ID0gYXJnOwotCQlmcmFtZS0+c3cucmV0cGMgPSAodW5zaWduZWQgbG9uZylyZXRfZnJvbV9r
ZXJuZWxfdGhyZWFkOworCQlrc3RwLT5hMyA9IHVzcDsgLyogZnVuY3Rpb24gKi8KKwkJa3N0cC0+
ZDcgPSBhcmc7CisJCWtzdHAtPnJldHBjID0gKHVuc2lnbmVkIGxvbmcpcmV0X2Zyb21fa2VybmVs
X3RocmVhZDsKIAkJcC0+dGhyZWFkLnVzcCA9IDA7CisJCXAtPnRocmVhZC5rc3AgPSAodW5zaWdu
ZWQgbG9uZylrc3RwOwogCQlyZXR1cm4gMDsKIAl9CiAJbWVtY3B5KGZyYW1lLCBjb250YWluZXJf
b2YoY3VycmVudF9wdF9yZWdzKCksIHN0cnVjdCBmb3JrX2ZyYW1lLCByZWdzKSwK
--0000000000006afafd05c512d221--
