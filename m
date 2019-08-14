Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69AC98D2A5
	for <lists+linux-arch@lfdr.de>; Wed, 14 Aug 2019 14:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbfHNMC0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Aug 2019 08:02:26 -0400
Received: from mout.web.de ([212.227.15.14]:51161 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbfHNMCZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Aug 2019 08:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1565784037;
        bh=t8u6NOCL16q9HtKndJQAxJduq4EJsS4RNVT1zyvjHSM=;
        h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
        b=YCqaWZzAw0SUEZtvbhQsMvYA6mJNQtr5zIIHJTHy97KzsDJmdBIZ9JI4QBqEN0BuI
         MtvWwMIXWs2bcn+VR8PcTpufbbJO0ZQhhhdcdlZ5uUGRIVK6slu3FlvG/3aTX9EaA9
         f0p8dHGm1wTBPtgY8aq1OcI02VMOc6GR4U2NvwzU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.124.172]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LlJzS-1iXTM31mS6-00b6JK; Wed, 14
 Aug 2019 14:00:37 +0200
To:     Matthias Maennich <maennich@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Martijn Coenen <maco@android.com>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        cocci@systeme.lip6.fr, kernel-janitors@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
        ",linux-kernel"@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-modules@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-usb@vger.kernel.org, kernel-team@android.com,
        usb-storage@lists.one-eyed-alien.net, x86@kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Martijn Coenen <maco@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Oliver Neukum <oneukum@suse.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sandeep Patil <sspatil@google.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20190813121733.52480-9-maennich@google.com>
Subject: Re: [v2 08/10] scripts: Coccinelle script for namespace dependencies
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 mQINBFg2+xABEADBJW2hoUoFXVFWTeKbqqif8VjszdMkriilx90WB5c0ddWQX14h6w5bT/A8
 +v43YoGpDNyhgA0w9CEhuwfZrE91GocMtjLO67TAc2i2nxMc/FJRDI0OemO4VJ9RwID6ltwt
 mpVJgXGKkNJ1ey+QOXouzlErVvE2fRh+KXXN1Q7fSmTJlAW9XJYHS3BDHb0uRpymRSX3O+E2
 lA87C7R8qAigPDZi6Z7UmwIA83ZMKXQ5stA0lhPyYgQcM7fh7V4ZYhnR0I5/qkUoxKpqaYLp
 YHBczVP+Zx/zHOM0KQphOMbU7X3c1pmMruoe6ti9uZzqZSLsF+NKXFEPBS665tQr66HJvZvY
 GMDlntZFAZ6xQvCC1r3MGoxEC1tuEa24vPCC9RZ9wk2sY5Csbva0WwYv3WKRZZBv8eIhGMxs
 rcpeGShRFyZ/0BYO53wZAPV1pEhGLLxd8eLN/nEWjJE0ejakPC1H/mt5F+yQBJAzz9JzbToU
 5jKLu0SugNI18MspJut8AiA1M44CIWrNHXvWsQ+nnBKHDHHYZu7MoXlOmB32ndsfPthR3GSv
 jN7YD4Ad724H8fhRijmC1+RpuSce7w2JLj5cYj4MlccmNb8YUxsE8brY2WkXQYS8Ivse39MX
 BE66MQN0r5DQ6oqgoJ4gHIVBUv/ZwgcmUNS5gQkNCFA0dWXznQARAQABtCZNYXJrdXMgRWxm
 cmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPokCVAQTAQgAPhYhBHDP0hzibeXjwQ/ITuU9
 Figxg9azBQJYNvsQAhsjBQkJZgGABQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEOU9Figx
 g9azcyMP/iVihZkZ4VyH3/wlV3nRiXvSreqg+pGPI3c8J6DjP9zvz7QHN35zWM++1yNek7Ar
 OVXwuKBo18ASlYzZPTFJZwQQdkZSV+atwIzG3US50ZZ4p7VyUuDuQQVVqFlaf6qZOkwHSnk+
 CeGxlDz1POSHY17VbJG2CzPuqMfgBtqIU1dODFLpFq4oIAwEOG6fxRa59qbsTLXxyw+PzRaR
 LIjVOit28raM83Efk07JKow8URb4u1n7k9RGAcnsM5/WMLRbDYjWTx0lJ2WO9zYwPgRykhn2
 sOyJVXk9xVESGTwEPbTtfHM+4x0n0gC6GzfTMvwvZ9G6xoM0S4/+lgbaaa9t5tT/PrsvJiob
 kfqDrPbmSwr2G5mHnSM9M7B+w8odjmQFOwAjfcxoVIHxC4Cl/GAAKsX3KNKTspCHR0Yag78w
 i8duH/eEd4tB8twcqCi3aCgWoIrhjNS0myusmuA89kAWFFW5z26qNCOefovCx8drdMXQfMYv
 g5lRk821ZCNBosfRUvcMXoY6lTwHLIDrEfkJQtjxfdTlWQdwr0mM5ye7vd83AManSQwutgpI
 q+wE8CNY2VN9xAlE7OhcmWXlnAw3MJLW863SXdGlnkA3N+U4BoKQSIToGuXARQ14IMNvfeKX
 NphLPpUUnUNdfxAHu/S3tPTc/E/oePbHo794dnEm57LuuQINBFg2+xABEADZg/T+4o5qj4cw
 nd0G5pFy7ACxk28mSrLuva9tyzqPgRZ2bdPiwNXJUvBg1es2u81urekeUvGvnERB/TKekp25
 4wU3I2lEhIXj5NVdLc6eU5czZQs4YEZbu1U5iqhhZmKhlLrhLlZv2whLOXRlLwi4jAzXIZAu
 76mT813jbczl2dwxFxcT8XRzk9+dwzNTdOg75683uinMgskiiul+dzd6sumdOhRZR7YBT+xC
 wzfykOgBKnzfFscMwKR0iuHNB+VdEnZw80XGZi4N1ku81DHxmo2HG3icg7CwO1ih2jx8ik0r
 riIyMhJrTXgR1hF6kQnX7p2mXe6K0s8tQFK0ZZmYpZuGYYsV05OvU8yqrRVL/GYvy4Xgplm3
 DuMuC7/A9/BfmxZVEPAS1gW6QQ8vSO4zf60zREKoSNYeiv+tURM2KOEj8tCMZN3k3sNASfoG
 fMvTvOjT0yzMbJsI1jwLwy5uA2JVdSLoWzBD8awZ2X/eCU9YDZeGuWmxzIHvkuMj8FfX8cK/
 2m437UA877eqmcgiEy/3B7XeHUipOL83gjfq4ETzVmxVswkVvZvR6j2blQVr+MhCZPq83Ota
 xNB7QptPxJuNRZ49gtT6uQkyGI+2daXqkj/Mot5tKxNKtM1Vbr/3b+AEMA7qLz7QjhgGJcie
 qp4b0gELjY1Oe9dBAXMiDwARAQABiQI8BBgBCAAmFiEEcM/SHOJt5ePBD8hO5T0WKDGD1rMF
 Alg2+xACGwwFCQlmAYAACgkQ5T0WKDGD1rOYSw/+P6fYSZjTJDAl9XNfXRjRRyJSfaw6N1pA
 Ahuu0MIa3djFRuFCrAHUaaFZf5V2iW5xhGnrhDwE1Ksf7tlstSne/G0a+Ef7vhUyeTn6U/0m
 +/BrsCsBUXhqeNuraGUtaleatQijXfuemUwgB+mE3B0SobE601XLo6MYIhPh8MG32MKO5kOY
 hB5jzyor7WoN3ETVNQoGgMzPVWIRElwpcXr+yGoTLAOpG7nkAUBBj9n9TPpSdt/npfok9ZfL
 /Q+ranrxb2Cy4tvOPxeVfR58XveX85ICrW9VHPVq9sJf/a24bMm6+qEg1V/G7u/AM3fM8U2m
 tdrTqOrfxklZ7beppGKzC1/WLrcr072vrdiN0icyOHQlfWmaPv0pUnW3AwtiMYngT96BevfA
 qlwaymjPTvH+cTXScnbydfOQW8220JQwykUe+sHRZfAF5TS2YCkQvsyf7vIpSqo/ttDk4+xc
 Z/wsLiWTgKlih2QYULvW61XU+mWsK8+ZlYUrRMpkauN4CJ5yTpvp+Orcz5KixHQmc5tbkLWf
 x0n1QFc1xxJhbzN+r9djSGGN/5IBDfUqSANC8cWzHpWaHmSuU3JSAMB/N+yQjIad2ztTckZY
 pwT6oxng29LzZspTYUEzMz3wK2jQHw+U66qBFk8whA7B2uAU1QdGyPgahLYSOa4XAEGb6wbI FEE=
Message-ID: <d3c852b2-0e41-1a7e-2f98-d8fd23cb8c1a@web.de>
Date:   Wed, 14 Aug 2019 14:00:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813121733.52480-9-maennich@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:PV3q8JAG3J44L4VLLpcjx+LJA+d2Q/O26Z4wCk/v79pZUEG7nh9
 m1L6YVDyqKxcYsDEo1kdMI3MgbeX/V+P0Gqzee44AZfe4AL3apOsTv/Vg7xoV69ns+9oPNS
 6nHNXYFSiW5jKwhQ+nlm5MSEFqWf6EALhLHVb8jUJ3nb2NbBpTqWiPRQyg4NQfk+sG9HksF
 PoUwjrb1WNlfH62NRqiKw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Afb82YE9Cjs=:aTmyYmgfN5b6+tl28ALxB2
 g/LjPRzs4TRfheufbLqQj/rntkKK77N+SvXrZJCE3QCV+/AH9UfldUS/5DhNK0RPccZOFywvU
 3KhfUbCRjF4wGdWjCPJ9JIarEbeSQ+U0p73paUXJIovLf4FGNxVG/fu7UASFa3W3RuFOdLnJI
 1DdDGr23zDK6XPsxyWhVWZwLx98xYlghohVnvOyhprghXD6IA9ZUJDvTR5s819OmT0zGY6HHJ
 Uj8BxBvBdvD72KcH0iru6y/nNWQZ8xBGkNvzemIwpp7mYD+nUgAYgsmILqOfpWiD2ZKaVlhAe
 yJ7JN+Gicmz0kVNrQlHMBKWo65W9beXwMzBFcPFLOg2oPrkIIXh6dcpAkLq3hz8EVVgTuN1dH
 GfpLpK+v+HwzD2SJAnhN8JecjcEQ/C9QuBRrByh+4f6lE3C0I256aZLdShAbhxIma6B5Yhxq6
 ZrMC2GmtBdDju5fnNoOJOdMNcXph7D/43eK7IOs8anLq4nE2LS/MJoEzDhcOoksQOt1CfMKDL
 KR5x0Y8vjWK+bZB9FzORrUc4r5bZ5Q1Y4njOPJC9OdLWcXLTt+vv1LsvhQhGArn1grSinl0xi
 wDUaOJDSO2mJjd5NXX0N/zRKYFyqNJd1EKEod/mOrAWGMpORjK3iN64taFoKE2JcBaIL76ev7
 GRQ/Pu8NfAtOBtPoMKKDcYIy/5H8CkvV4OVwZURmW/25BJns71iy17MNFCWm6UvF2L1FdxQZ5
 1qsv2xxkgeWkMLWaBTlHdydOKHhL/H3CDwmQRKrF9Pxk/VxF6Lcc0ndjczIdZCgckvYgNHHax
 +jVNosPn9BioqwX5gtXfJJM6/V1FEVyIor9GnzxJwWBfk2NL4B2JSjun3gZnS9MKowG3B4I/K
 MgEtx4MxByRnJE8krxp8Xhfps00TdMelOsMidCmmrll1t6igulsyw981wkVBBx+lElpuz+DZo
 4e2Ou5SILwFHnFVCu1nZZ8+CQaB+xV6tPgzKF3nW5GBCPjCfMyq/721rDCiicv+8mtgxtBqNW
 4lJlGWmwaqRTQYJ0OyoddYMFIQsYJtAVF5leDof9DZkZuh8o/VabyEw4ZzPKZLpi+0ecrhdKI
 qiNnz2H6znKE/SU42ll39Ie9PDt5iaUxuGPiUXVwNwpE6yhvtcnwIHk3HfmILqDXtoU7jOP9h
 eJrQ8=
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

+# This script requires at least spatch
+# version 1.0.4.

How do you think about to avoid the duplicate specification of this identification?

Regards,
Markus
