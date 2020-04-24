Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CBD1B7781
	for <lists+linux-arch@lfdr.de>; Fri, 24 Apr 2020 15:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgDXNvF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Apr 2020 09:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726301AbgDXNvE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Apr 2020 09:51:04 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CF0C09B045;
        Fri, 24 Apr 2020 06:51:04 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c63so10195759qke.2;
        Fri, 24 Apr 2020 06:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fgJguWGGGlAwhNoBLU8EzUqvt2IciwBdbaU2eBO5bRQ=;
        b=ZpSrIlJFDAQM2PzcbDXbif7ws5tgVsC+SiR4zGfEblxvm086ureP8r1nAITfl8TIOy
         GOkHU0Cscq5l+LM684La5i3gk7cPZbCa2RJz7An5lly6zB7wUEIpwukKeQrxg/oG4JB6
         1epMl0zCFhVwi6KydpE32wQFW2goQwOzMyRv8uK6V9qzlwSYr1FEZFyRd223cPiKKFae
         kPQvywYLasJWWSG7jzSITghE7vV8tfJ7Csz9eEV7xaPJMDehUKU3jBZapUnzf0Q/e1Y7
         zoJcJI1puU/0SYKl7j0YbtGFVfNcoIJ9G+HGChIzjOX48DIis3JCkKaqHiNpBNOyC70x
         szRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fgJguWGGGlAwhNoBLU8EzUqvt2IciwBdbaU2eBO5bRQ=;
        b=t/Jt/vJxZFswOQjE5k/dy+bQoex60vLAvryBlF7MudY1MnKxajXY6oHLN1WNIbhQkP
         a4UX2HvEBDPTjY/F5/6wiTVxm6r+/uNAde2fZVJyUwWguwPvk2gITNiHlO+Tp19xpCre
         9pU/X3xJD5Rm8MyqI/V6zPFNEW9NdLWXfbHo7XwxFfGo3EAE6pi5nfso5yJzpQPXatdS
         j8Kd6j6yfh5Z/Y0N8vfydgBkGavrE9SDELCW3CeALA5uLtMAv4v3YByRsmRCf9HUaiRk
         m5teFkgjUKjPkj08UORO/Q36N/ryWL5VQHIOiiXcqsndwFtguPHIhPNMlBRioRsTgcZ/
         eV1A==
X-Gm-Message-State: AGi0PuYXxP49YLYcUY1zBLMMp91nkPbLBGQ093ZpnW5EzlgmWqZbbVXm
        yg6QKxa1QoSvYF7lz3RxCUo=
X-Google-Smtp-Source: APiQypItRiDO2aQPCX87jaYTk5YAO3bdQyOshfgS2sb8Hqf6eQRZZNBqqaJDaEAmj1prQvI5CMGfng==
X-Received: by 2002:a37:48a:: with SMTP id 132mr9342479qke.390.1587736263497;
        Fri, 24 Apr 2020 06:51:03 -0700 (PDT)
Received: from icarus (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id z6sm3741966qke.56.2020.04.24.06.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 06:51:02 -0700 (PDT)
Date:   Fri, 24 Apr 2020 09:50:33 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     akpm@linux-foundation.org
Cc:     Syed Nayyar Waris <syednwaris@gmail.com>,
        andriy.shevchenko@linux.intel.com, michal.simek@xilinx.com,
        arnd@arndb.de, rrichter@marvell.com, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, yamada.masahiro@socionext.com,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, linux-arch@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/6] Introduce the for_each_set_clump macro
Message-ID: <20200424135011.GA3255@icarus>
References: <20200424122407.GA5523@syed>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline
In-Reply-To: <20200424122407.GA5523@syed>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2020 at 05:54:07PM +0530, Syed Nayyar Waris wrote:
> This patchset introduces a new generic version of for_each_set_clump.=20
> The previous version of for_each_set_clump8 used a fixed size 8-bit
> clump, but the new generic version can work with clump of any size but
> less than or equal to BITS_PER_LONG. The patchset utilizes the new macro=
=20
> in several GPIO drivers.

Regarding the nomenclature, I created the term "clump" to represent an
8-bit value that was not necessarily a byte yet was a contiguous
grouping of bits. With this patchset, we now have a more generic
for_each_set_clump macro that can handle values larger and smaller than
8-bits.

Would it make sense to retire the term "clump" and instead use "nbits"
where applicable, in order to match the existing convention used by the
bitmap functions; for instance, would it be better to name this macro
for_each_set_nbits?

William Breathitt Gray

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl6i7qkACgkQhvpINdm7
VJIciBAA4lGCd+eUHQXeYgvLK14UXVfbjASoiUjFVFetkDeXj+GGFQG7W/fVMxrM
LoJV4wXwNl9qyedfdNI8aZmjUwF2Tyy+XEaxo/wa6XyfIXvKrqDYNpESIhvFgMv9
BcxDVlWrMixZ440pQqqFRfGx7bLM2pryn05hh5yr46Y3kZZRISeAlygC+cZfDmzT
O7KXcRIB4ZTeZ0irSlLKsEFpp42YIKUX+gt3zwkxSoRIhfBRToE2KU42oLhez48t
WuUHpZ2TexCV35B+QAjjAXqMdnL3Rg43pRCJG614VuvSleY2hAkED5lqMlt0SIh4
4kEbvK/fea2QInYY/WA5EKxtFka9huXJ1dhqqUUSFFQfUPhqA/GSxpZ+5o7EeWjr
v4d4uzg897E5BwZhrWOJUHBIfA4LXkQMV+ZGL1ijWmNnYy3uigREGZYrNylShQ1O
INlHzTcoqy++g+kETBV/MEZJWGbtqRGqr4/u1UaECO/Ccy0cHDhp9mQ0JmSoXdQe
pIIhBDfm3raffCMVjSqfVToHENxHuwqcTIgxJ+CAR7j2BOAF/oeNULgsKnRZrfMu
UE32VfmG2xXdHiqw4R/fBzK1g/DLF7c04RYBPjY7S1/Tvrox9dTnfJbPA1r4KB35
vIQf2L/hGGV/F/IRYgVdtVVVNaB3qEsrimj0CJjnpQYNkE3fUoM=
=A+Kx
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
