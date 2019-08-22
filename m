Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C303898B41
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2019 08:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbfHVGLO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Aug 2019 02:11:14 -0400
Received: from mout.web.de ([212.227.15.14]:58157 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727476AbfHVGLO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Aug 2019 02:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1566454197;
        bh=TPWE1k7o/B4f3kwbr1YU20EaviM7gzdQpubK6giRGHs=;
        h=X-UI-Sender-Class:References:Subject:To:From:Cc:Date:In-Reply-To;
        b=oEgDK/P60u9I0vquCLDYeSq8mCNR1xF6msLm/XXAQiH/DtrzvwcvksW6EmaA12g0+
         4NfDmGA7mNFkf8nUcRuooqyfX+Mn8MV9mdAT9HL+zWjXjocyIYPRBFwKveLKbSNCVY
         6bLF958lUWVtsMcgxhevB8kO7WqZDU3dEmz4KLQw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.181.43]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M5woT-1iC9T330vZ-00xuA3; Thu, 22
 Aug 2019 08:09:57 +0200
References: <20190821114955.12788-9-maennich@google.com>
Subject: Re: [v3 08/11] scripts: Coccinelle script for namespace dependencies
To:     Matthias Maennich <maennich@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Martijn Coenen <maco@android.com>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        cocci@systeme.lip6.fr, kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
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
Message-ID: <81cc3995-ea95-8125-bbd2-2889cc623e23@web.de>
Date:   Thu, 22 Aug 2019 08:09:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821114955.12788-9-maennich@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:9LZl2wqzsp0x2TafjaRoU9EeqxgnDZXFmkrC+Ti/L+vIL7UfNgB
 V2wq50MMJAjg3qd+NPRguYavUCq2c0qLxxDHvaAe5scbimexXV/Ncs3jW+9ds31dwOMnEEB
 EeRiQ0HkGh/y3pr3T76fb2FUcWEXrdC/SfezhDcPKBaYstMAQoitoEpZjPiKOKji4V0R+Y1
 M42nA81yVvaIwy3RZYSZA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:74ZF/xIKr0s=:GBPByv/WtB8BREl4ND7A4T
 /O8T2WRGmwzT6+GqOAchW6m8RRFU/1WvakBWvlMt1lvammmiN1QCRCiWtaHOLH3+bqd4xGLNr
 oMDI94/4MhmvVhrN3RtHsazBYQkU7mYr63v4s4WoHi5QWfYXkdHgfQuCbdBWUQuvmTJHaPS1m
 QhICR4e6GZeY9Nu5Jmahoql3WXsKSYAHmMe5xkdyytmDkT1avaAApqfOq+xpAOQE4SCHRum3g
 vtginvig3BFOaaY6w7F/bDZLv3l55yw483G4sEFV34JW9LHtmjVisdCu4v7/yBKATV9eysxLi
 7IvfjA5i2BsfXqI5vJX8Dh5dSVjHz/hiyz6h8AlbkK4IoskyqT6aHnVMogG3/F0TIGvxmQfSt
 iK0z0r7JjxXvrEBoPsDA/Cu/hEQCRcYjmUGB6e1cj4iavq5cIwWYqEhXW5/cmBbkQRpoHCDjW
 ISJe+uf8963TNP1Z7u/AylBQiCTPYoFUQSNjWfzqGDU2i2SR/tEGT8p6DATTQTVx2A2OiuHee
 tk8XzgVBUOszuo3YJhNWwvLgXzPHC+XXuvH3cfbtCS2d7HYxBi6a7IJji4jOQ62Lw7SnBP4Er
 N3tKgUfuYUG43a8kD9mil3/BzIBxMqGZLBckaoB9COCmJMOwXhM6qjgZbItwK1FNuBG9U0DdW
 2FWhNJFDgIuJwgS28pZ0IotxlsScTlxzJSQHSSXMOF7Bxvchdk9ghfMwp71AUvxkscL3e6eBf
 tz7PBNLau2P8p/A1Hm6H6+MHL4zhort+onoFO+rucsSnPJ8qe+mtbF252SPiHrUVmDB4LtmpY
 LoDV6LoQqKUf4Hsr/izzxcZvON33hVNbpXhF9aZLi/g3UvgWq/wM14wLGNxnXMH+uLI300/fE
 25MuUl2VLvqZ9b5PZiXxa1ZWC0YvT5RwuUVDZsQLBogXWoIMp9T0XcvedoCPVZHdkrnevdaLt
 DF8v292gp3iHEBQAJxBuXUTrQRyRZbdMajlXwDixNfezHNxK6o8eNwAm0B5V7pmqy+u7NTcoh
 3sQApVFYq1uoPJIE9DTtn5FR52IhfUUq0wBLrD6czRcyCjCtI9xmOzicGnZ0FQR2lNeXTU+tO
 VhQkzYFNyxKAQa5NlQRI56bA4KApICoxGn+Z2YSXSpoFn/YoNcFnal5NOmfSAqIbB1r8VJMVp
 Vij6o=
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> +generate_deps_for_ns() {
> +	$SPATCH --very-quiet --in-place --sp-file \
> +		$srctree/scripts/coccinelle/misc/add_namespace.cocci -D ns=$1 $2
> +}

I would appreciate more constructive answers for specific software development concerns.
https://lore.kernel.org/lkml/1c4420f4-361c-7358-49d9-87d8a51f7920@web.de/
https://lkml.org/lkml/2019/8/15/515

Regards,
Markus
