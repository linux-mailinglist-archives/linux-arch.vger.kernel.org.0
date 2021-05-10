Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF930378FE4
	for <lists+linux-arch@lfdr.de>; Mon, 10 May 2021 16:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237389AbhEJN5T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 May 2021 09:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235146AbhEJNwN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 May 2021 09:52:13 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4412C034612;
        Mon, 10 May 2021 06:31:57 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id k5so182516pjj.1;
        Mon, 10 May 2021 06:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:references:mime-version:message-id
         :content-transfer-encoding;
        bh=UDrZA8LYoy62mejg38ULfDfRvmzFbsPo8ortPrEf13g=;
        b=KYCt1LqLZ7Fb4bQvqLnrhQ7awqFWwyp0feXtDJtw99j5JFXMYtDH0LRw0Cp0eVVyft
         NkfB6HyWHBFPsIqyWgiBuJ3Sod5IierE0V+Qqea4aMig7wYxyFIWeQu3clyZqWIVognx
         Ndrg5/zoEmd/byX3U7X86GAAWbQuywmBldsz7hX6XZ4ypUiinQD5kf389d5LEj54OMqC
         GnOetrBDjq4o8QMbHS/CdJ0456Jaucf1elLJFdIslQ0eISs8LCAhmcm+y5unUVc6VmMK
         /a9e6PFihwC3eNozaITV2PZogbHtKopE73yEupl5R4mRn3iB3Ms3mBlJZunUJfOCrXuo
         AncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:references:mime-version
         :message-id:content-transfer-encoding;
        bh=UDrZA8LYoy62mejg38ULfDfRvmzFbsPo8ortPrEf13g=;
        b=bLoqbo0j+qqNVvmmxvrphWLfuR7RDQLYDIWEmpoNkCd4eUftnnAYiQdiY07aPI1CVB
         9Sv3yazYwzb9tDpybqiPa95H5FSBXryiDiUEVIJJxxAHi77kWjqIFI5rILAdxzpko+Gv
         fVTGouuZS1ntD9hEERCGj2j0j5RPNxqvCGIYdFjlVT2MyX6qzQ9DpcPSQDJIJ4t+9BEI
         aygJGG6GpO9lGoYsK9haIxSlfWeRKKtJZnZvjQ/XGJZnVvOvi5yrvxqQDhJ0WJkzXlAv
         GBmTeFQmRDVXnsH2FnylTahoIzNO5v7Y4+grHZo5dWe8aPUrxqT8iC7OQxAEQmcXarNn
         m1AA==
X-Gm-Message-State: AOAM530s7JaVWAcKnZCNACX4a0lPq5XdToyTehobaLCnsnKi2GyyHmvB
        +y0wVexdZEoXM7VDTldotbc=
X-Google-Smtp-Source: ABdhPJyel3QzA4FjOmbcdobjhd3/QAGazjaDaJ1lYLxwlHoWZZgzqwQRZIvAEBUzRG0oK72PHXiV1A==
X-Received: by 2002:a17:902:854a:b029:ef:3f99:91a7 with SMTP id d10-20020a170902854ab02900ef3f9991a7mr2355511plo.74.1620653517287;
        Mon, 10 May 2021 06:31:57 -0700 (PDT)
Received: from DESKTOP-2BQJOC8 ([64.71.185.171])
        by smtp.gmail.com with ESMTPSA id d22sm5241427pgb.15.2021.05.10.06.31.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 May 2021 06:31:56 -0700 (PDT)
Date:   Mon, 10 May 2021 21:31:50 +0800
From:   "lambertdev@gmail.com" <lambertdev@gmail.com>
To:     "Johannes Berg" <johannes@sipsolutions.net>,
        "Peter Oberparleiter" <oberpar@linux.ibm.com>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>, "Jessica Yu" <jeyu@kernel.org>,
        linux-um <linux-um@lists.infradead.org>
Subject: Re: Re: [PATCH v2] init/gcov: allow CONFIG_CONSTRUCTORS on UML to fix module gcov
References: <e386f13f8496330cd42e93c6d48a25b9a57a6792.camel@sipsolutions.net>, 
        <20210120172041.c246a2cac2fb.I1358f584b76f1898373adfed77f4462c8705b736@changeid>, 
        <ee3bc3bf-9582-d278-5b7a-d9fa27b17800@linux.ibm.com>, 
        <tencent_99073B61C8137C88B76C231139F94EFB3805@qq.com>, 
        <2a46ca787df9a44c8b4fbc17ab6b69247ab38400.camel@sipsolutions.net>
X-Priority: 3
X-GUID: CCDC8702-C70A-48BA-9472-59D1613C5ADC
X-Has-Attach: no
X-Mailer: Foxmail 7.2.21.453[cn]
Mime-Version: 1.0
Message-ID: <2021051021314677744820@gmail.com>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

SGkgSm9oYW5uZXMsCgpNeSBvcmlnaW5hbCBFbWFpbCBhZGRyZXNzIGlzIGJsb2NrZWQgYnkgdGhl
IHNlcnZlciBvZiBrZXJuZWwub3JnLCAKc28gSSBoYXZlIHRvIGNoYW5nZSBhbiBFbWFpbCBhZGRy
ZXNzLiBQbGVhc2Ugc2VlIG15IHJlcGx5IGlubGluZS4KCj5IaSwKCgo+CgoKCj4+IEhpIEpvaGFu
bmVzIGFuZCBQZXRlciwgc29ycnkgdG8gYm90aGVyIGJ1dCBJIGhhdmUgb25lIHF1ZXN0aW9uIAoK
Cgo+PiBvbiB0aGlzIGNoYW5nZS4gVGhlIGRvX2N0b3JzKCkgd29u4oCZdCBiZSBleGVjdXRlZCBm
b3IgVU1MIAoKCgo+PiBiZWNhdXNlwqAgKnRoZSBjb25zdHJ1Y3RvcnMgaGF2ZSBhbHJlYWR5IGJl
ZW4gY2FsbGVkIGZvciBFTEYqLiAKCgoKPj4gCgoKCj4+ICpfX2N0b3JzX3N0YXJ0KsKgIGFuZMKg
ICpfX2N0b3JzX2VuZCogc3ltYm9scy4gU2VlIGxpbms6CgoKCj4+IGh0dHBzOi8vZWxpeGlyLmJv
b3RsaW4uY29tL2xpbnV4L3Y1LjEyLjIvc291cmNlL2luY2x1ZGUvYXNtLWdlbmVyaWMvdm1saW51
eC5sZHMuaCNMNjc2CgoKCj4+IAoKCgo+PiBJbiBteSBlbnZpcm9ubWVudCwgVU1MK0dDQyAxMCwg
SSBjYW4ndCBmaW5kIF9fZ2Nvdl9pbml0IGV4ZWN1dGVkIAoKCgo+PiBiZWZvcmUga2VybmVsIHN0
YXJ0cy4gU28gSSBkaWQgc29tZSB0cmFjZSBhbmQgZm91bmQgZ2xpYmMKCgoKPj4gX19saWJjX2Nz
dV9pbml0IAoKCgo+PiB3aWxsIG9ubHkgZXhlY3V0ZSBjb25zdHJ1Y3RvcnMgYmV0d2VlbiAqX19p
bml0X2FycmF5X3N0YXJ0KmFuZAoKCgo+PiAqX19pbml0X2FycmF5X2VuZCouwqAgCgoKCj4+IFdo
aWNoIG1lYW5zIGlmIGRvX2N0b3JzKCkgaXMgbm90IGV4ZWN1dGVkIGZvciBVTUwsIG5vIGVsc2V3
aGVyZSB3aWxsIAoKCgo+PiB0aGUgY29uc3RydWN0b3JzIGJlIGV4ZWN1dGVkLgoKCgo+PiAKCgoK
Pj4gU2hhbGwgd2UgcmVtb3ZlIHRoZSAqIWRlZmluZWQoQ09ORklHX1VNTCkqIGZvciBHQ0MsIG9y
IEkganVzdCBtaXNzZWQgCgoKCj4+IHNvbWUgc3RlcHMgdG8gbWFrZSB0aGUgR0NPViB3b3JrIGZv
ciBVTUw/IAoKCgo+CgoKCj5ObywgdGhhdCBkb2Vzbid0IHNlZW0gbGlrZSB0aGUgcmlnaHQgc29s
dXRpb24uCgoKPgoKCgo+UGVyaGFwcyB0aGVuIHdpdGggdGhhdCB0b29sY2hhaW4gKG9yIGNvbmZp
Z3VyYXRpb24gdGhlcmVvZikgd2UgbmVlZCB0bwoKCgo+cHJvdmlkZSBfX2luaXRfYXJyYXlfc3Rh
cnQvZW5kIGxhYmVscz8KCgpZZXMsIHRoYXQncyBob3cgSSB3b3JrZWQgYXJvdW5kICBpbiBteSBs
b2NhbCBlbnZpcm9ubWVudCAKKGNoYW5nZSBsaW5rZXIgc2NyaXB0IHRvIGFkZCBfaW5pdF9hcnJh
eV9zdGFydC9lbmQgbGFiZWxzKS4KU28gdGhlIF9fZ2Nvdl9pbml0IGlzIGNhbGxlZCBiZWZvcmUg
c3RhcnRfa2VybmVsLgoKCj4KCgoKPk9yIC4uLiBtYXliZSB0aGF0IGFjdHVhbGx5IGp1c3QgbmVl
ZHMgdG8gYmUgcmVtb3ZlZCwgc28gdGhhdCB0aGUKCgoKPnRvb2xjaGFpbiBnZXRzIHRvIGNob29z
ZT8KCgoKPgoKCgo+SG1tLiBQcmV0dHkgc3VyZSBpdCB3b3JrZWQgZm9yIG1lLCBJIHRoaW5rIGFs
c28gd2l0aCBnY2MgMTAsIGJ1dCBub3QKCgoKPnN1cmUgZXhhY3RseSB3aGVyZSBJIHRlc3RlZC4K
CgpJIHdpbGwgbWFrZSBzdXJlIG15IGVudmlyb25tZW50IGlzIGNsZWFuIGFuZCB0cnkgYWdhaW4u
IApDb3VsZCB5b3UgcGxlYXNlIHVzZSBnZGIgdG8gY2hlY2sgd2hlbiBfX2djb3ZfaW5pdCBpcyBj
YWxsZWQgaW4geW91ciBzZXR1cD8KZS5nLgooMSkgZ2RiICp5b3VyIHVtbCBlbGYqIAooMikgYiBf
X2djb3ZfaW5pdAooMykgcgooNCkgd2hlbiB0aGUgZXhlY3V0aW9uIGlzIGJyZWFrZWQsIHVzZSAn
YnQnIHRvIGNoZWNrIHRoZSBjYWxsIHN0YWNrClRoYW5rcwoKTGFtYmVydAoKPgoKCgo+am9oYW5u
ZXMKCgoKPgoKCgo+CgoKCj4KCgo=

