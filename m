Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C96B8ED60
	for <lists+linux-arch@lfdr.de>; Thu, 15 Aug 2019 15:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732560AbfHONwL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Aug 2019 09:52:11 -0400
Received: from mout.web.de ([212.227.17.11]:58553 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732426AbfHONwL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Aug 2019 09:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1565877058;
        bh=YUTbKXcF836pqlmd+GHK0s0jvKYx8jX9645NuzKoc7k=;
        h=X-UI-Sender-Class:References:Subject:To:From:Cc:Date:In-Reply-To;
        b=KgJmqRyPDIetA4qOfCfa0vdb+hzQHCBCeg8YTXnYD0uFAPvkcILuHeKCLTGqckReE
         Jmnnbe2ZaWzv1xbZ7LGaFI275I8ONPF165vNAbPuM1UkugwET9UrZGOUjzJQ8GGRzP
         bJ/jwwFKF/7faF2IKAlI3JmXiZnrsgMNfBshD4ys=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.166.62]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MEmc2-1i5Om33dqU-00G4bN; Thu, 15
 Aug 2019 15:50:58 +0200
References: <20190813121733.52480-9-maennich@google.com>
Subject: Re: [v2 08/10] scripts: Coccinelle script for namespace dependencies
To:     Matthias Maennich <maennich@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Martijn Coenen <maco@android.com>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org
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
Cc:     linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
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
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Message-ID: <1c4420f4-361c-7358-49d9-87d8a51f7920@web.de>
Date:   Thu, 15 Aug 2019 15:50:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813121733.52480-9-maennich@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+FHLcw5Oh+i+mzj0ruQa0CIaAeBv9tnj/KibU6t6ZI0fA47jyvV
 o5S6DTDC5vZsdpqgO6OE8iv+sFnTFrFFq/5OUiwLJZiOhdxuRZy4ZJQqfK4liH3JjWe1Ba/
 N1qX0oduNJn3qynA6IKIalv1iW6teTnbEyaZhaEmWVXcX8fIQhNosUg8PqWDmc7RROozQzV
 FzLcBzPcyiAGe2ZaND5uw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:925k6T7hUBg=:oFM6u0kRagHrG60YF+JTjq
 T2E2bJQM+7ZcDCv82qBIWqW5L1xqRPh7uItzxODRLXL8gf1EvzbMY+YRXkpCSVXg6QBI+I7Zc
 hezrj9xKbNNwBQQGiRYeqH/+NOCrMG7xv2emhvOClGG24piZblObHMT/3gDHahZVY0NVglHS1
 kXbP97bQTDIyTsFc2O1Trzl6OGn6trJi7Q9Wgoo4lXcAg/Ro+O+hZf1lxexO4tLLuehCaVK5K
 gr3dpSUYGuKFVEvcgMj5TDjq1Vd35mUBg/Z3vu8j5biKBKBIFphiBVHre82fWNS9rhLdwNenz
 iNBwNH/IeVI0LwrFWtGkGWZalAmcKmlcJbEuwPiCt9a1FXJBgxftpay3weAlR2NAmtTzstc2t
 9MJb3uxrXn6s+xut5OC21OU6toi/iey1DYgCvy/RM+REjnNgPGnlroMsVz0BdmlrqjU/AUyoh
 q5t0BJ0e2L80xOTkBclEBMEcDgqPq0mjv2ivI13NwiHKyShPhBr2qKIOjX3k2WqVp4Dgc/Ub3
 7CDVvBCPwPG1UeTHy7ktAv+OLggsrHVPwrpDK9joS5g+ia5Bxo05TvTsM2shish0FLvlKk1PN
 f8WHecipbZPJbwwXzH2yasywwgLPfas9nIHcuF05z7IA2cT29j8xuh4KcQFu3wb+Na7JKcxV7
 zOQ+T0BhNG2heW+nMTMjlpDWBz7kTjTsT7QYZG82ykZrztL0XYlyY1yP2BKOLnGE09EUmOvjP
 NCBDvLlv/p+Su6B9zADQI2Aucda3fxYrPrzEFyujc0OLu6YChXtPJD97UlYgMw33R4U7J0Enn
 2M+xbaXFruogJz34Z7oy0oMLpw4Bt9sPdDGc2brczayAswqOmUaqD0I6pLU7yoKbq24Vy7IJu
 x7dTf2JfczQx5rDqbsiYtTIFAIiDpxUZohnZ9FO4uNFhx0JcP321qaYZ0iIE0MBkBpDi5R9H1
 1atDS/jrSSfNO/00KeI/IeweTN7iTqXIXiJPLyPIy8dsm0tptxwnUrl0Gek3OKVWoKWcZKOz6
 M2NXXAbj0kRGU5b5tHXZRgB+pOkdI+Doje4RHqdAWynXf6anDnBvdjilfZOGs5LnB8VIvuncT
 3OwKfvfottopcnS41zs8RTFQL9b+ji8W7AT0+k/rCvn5ieVBg04tbKT9jQ8DSDT9inlGSpkKK
 7fMbFccXl3DCAXLcEKuv5VrS1vRIA+Ltw09k1aOzf9wWmUCQ==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> +generate_deps_for_ns() {
> +    $SPATCH --very-quiet --in-place --sp-file \
> +	    $srctree/scripts/coccinelle/misc/add_namespace.cocci -D ns=3D$1 $2
> +}

* Where will the variable =E2=80=9Csrctree=E2=80=9D be set for the file =
=E2=80=9Cscripts/nsdeps=E2=80=9D?

* Would you like to support a separate build directory for desired adjustm=
ents?

* How do you think about to check error handling around such commands?


> +generate_deps() {
=E2=80=A6
> +        for source_file in $mod_source_files; do
> +            sed '/MODULE_IMPORT_NS/Q' $source_file > ${source_file}.tmp
=E2=80=A6

I suggest to assign the name for the temporary file to a variable
which should be used by subsequent commands.

Regards,
Markus
