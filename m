Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2C799191
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2019 13:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732524AbfHVLCi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Aug 2019 07:02:38 -0400
Received: from mout.web.de ([212.227.17.11]:51915 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730824AbfHVLCi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Aug 2019 07:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1566471667;
        bh=fSi6cWFaSQ0x6nDQUYLY6OAW6AFAxeqc6jMqBG94KAY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ISflFQl99E4tz4ceXXg+5PQ++N1GqJLDoVjvO3BfljlQHgnmXQnHV6pagLLw1RLE/
         J16mQpZu0vxxilKTSjeLBxi6vi1nGZPHLcqZ2IKM759RJ5L++YyJH5MOudiu/S7CKG
         16I3VJtULaMAw7ebIDC+bZCvDOPDv1RJy9C+M8g4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.181.43]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MPHC8-1hwKzD1yPQ-004WnY; Thu, 22
 Aug 2019 13:01:07 +0200
Subject: Re: [v2 08/10] scripts: Coccinelle script for namespace dependencies
To:     Matthias Maennich <maennich@google.com>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Martijn Coenen <maco@android.com>, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-modules@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
        kernel-team@android.com, usb-storage@lists.one-eyed-alien.net,
        x86@kernel.org, Alan Stern <stern@rowland.harvard.edu>,
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
References: <20190813121733.52480-9-maennich@google.com>
 <1c4420f4-361c-7358-49d9-87d8a51f7920@web.de>
 <20190822091858.GA60652@google.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <796bc082-7708-172e-df1e-13447ef6b577@web.de>
Date:   Thu, 22 Aug 2019 13:00:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822091858.GA60652@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JF8q7yHwaG8Z/LvlfWxM/FJGlvOsYVq48Xk2voGAeER7agkzXmb
 imUiCrA8SoJqG6lD+KXHmQQKTw1GktilOhqtGreGUxKxzYyC03AljSfnHpdlTynBYLtUqpd
 K0DilrlWUwXIexw8YWofh9dK1jOucDo6ogWAJfPGY5jSamTVsZbRvLDnBC7Nifkks9buQo2
 lRkBFMrL6oexvkaeouILg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/9cTn/pOFhE=:GRPJRkw7kkrDo0NHlJDo13
 3SLYxn+cZbJKo0GVguhEqlrIICCVxLhjOdymDeSXLrT0dGU9Dgmf/NzCvH7kIuGtjgsM+DOh0
 I97UqFlcaH9EvXOmrgRQ1FqLBt7Qi/lBsjEMMY/n9XzCVB3eh6edUcV9WEajDxZ93QXrSoH0+
 ioIzsrQFQ0/6+rA5J1zwuxgiyyQoNOSyML36FE7oMOh6kqAgx7BzWC51Qt011NiFKpdIId4e5
 piKIOk3DG0vXpoCPO9fv484RBCmOvxd1mt4W4hFaWqS3IM7rSf3FgJ/LcL7uVaMrRL+5wlpzx
 N1W/DwQRDfRVRoWE61ZtBDb50TTK1X4xHnoI4EcivabGYlVXKTAa/M0UuoIXMktJMLazBjG5N
 eUH/ZeZOl8b4h+5CgRB+wYi2CJY0QIhpAPI7uzPa8hi1w82TaGipGLXEOaUc4Q5OIZZJDZB5R
 KgTpYD3likaiy7Z1hbjoAVGYkPRQmQHjr69bt/UUa5v+OMXKCMxPpHRLUZNP4JZnwujufK9BN
 05p1Z7GR8iUnVrrBXjJp94mwLnbfwSiQAS8AgvZgethS1HpCF+TMzgLxcsO45NzvkgNp+Szcj
 O/Nh6mn/bNNmroiZB/s7fDOIWyWEHuDBzXYVDJBXtZHlWfPXGSKOmrOXkco25KxE7w62eqhTy
 wHLyMheme+xFDOTKbjr2AZVXp/xM6+h7uMAAtfhl6+RrQC0edXU8KLuzGXRLsvWAn2fwsAgsk
 qlxUkhfiVKD+sQVZ3P51Zg55JskCWj+hfra2ux3qhHpxc/nVmQPRjsj7Rt8Lr8HNa2wxQS1u0
 X+1zUCSk7y/Fvje8vWZLCAbXX5VqHmr236NmyV4dxTDupCw0zBGwgJVPUvHA0VTyWeHjWdauI
 Dqn5aLl17myXBCimbrarB7nUq+4VSrBlr840+guWfzQWSTI0QfeZ4ECzxXHhBY2q+AsorZc92
 T7RxEkxjbiWNG6bgFiUFbtGDMQaq0XMM2tpz2/Opr120PCTkDirqQQjcnY8YYqSJN6ohqSfu2
 wxDo1xupCfu9O3/W/ibIS2YZBvs10b2aK8UgaynvZsEYX39C6xNe7XE6e2Z7SPfvK4NcWME+7
 0LA0GrEHTn5fQ8Ezr85+/jqUKWBjZaUpjB8mvQn49B+vMFep606+66eimpJGiUTVTMMKiMzDH
 dpvenjTHKLV3NVUav8dBz+AXLM0HQBjIgRYEYWkrlmN9ypRQ==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> $srctree is defined by kbuild in the toplevel Makefile.

How is this variable passed to the file =E2=80=9Cscripts/nsdeps=E2=80=9D?


>> * Would you like to support a separate build directory for desired adju=
stments?
>
> No, as the purpose of this script is to directly patch the kernel
> sources where applicable.

Will there occasionally be a need to provide a generated patch
(without in-place file modification)?


>> I suggest to assign the name for the temporary file to a variable
>> which should be used by subsequent commands.
>
> I somehow don't agree that this is an improvement to the code as the
> variable would likely be something like ${source_file_tmp}.

Would you dare to choose a shorter variable name?


> ${source_file}.tmp does express the intent of a temporary file next to
> the original source file and the reader of the code does not need to
> reason about the value of ${source_file_tmp}.

I would find a code variant with less suffix repetition nicer.

Regards,
Markus
