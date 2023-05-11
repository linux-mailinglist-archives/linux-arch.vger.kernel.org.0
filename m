Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659B36FF717
	for <lists+linux-arch@lfdr.de>; Thu, 11 May 2023 18:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238132AbjEKQYj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 May 2023 12:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238130AbjEKQYi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 May 2023 12:24:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FD6FB;
        Thu, 11 May 2023 09:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1683822227; i=deller@gmx.de;
        bh=+1RFIFdc+C/sb8btmAfnn4ecF6JeppQ7CGFV7/Ay2bo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=fE4EWlNpT+ffSVec/R0JBr0E35YQQCr+5MrexDeEuUi4zEG00TTEyNNIu9S1+fYZG
         x+3wQYYS5GZL4f7lOylNuxYkgeEToeU7kHttMI+lrzAe0uIQ0S8EeapZz/UBTPSKKq
         ZJwj83/GtkJe7x5RQJRp9hmY8hHZj8Wl4KP+YLRBX/BevRH188AjN0kSmwGnT6UveV
         rZ8SQKT4OAX7pwlRgCz/XkzUrnPGOvMtQp4o90s7eFRlRSf12cpSW7VU5BDZSS0DmM
         p35c0DsFv6IOr/ikF0TnCNQrgAhEv4xF+0Ej+x4eAgo7+Bf8gRgD+ZNG6vylepESqi
         W0COL/VAhsGyw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.146.253]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEFvp-1q4bLD3YJR-00ABLJ; Thu, 11
 May 2023 18:23:46 +0200
Message-ID: <89099ac6-21f7-3538-8830-57baba256684@gmx.de>
Date:   Thu, 11 May 2023 18:23:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 1/6] fbdev/matrox: Remove trailing whitespaces
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Sui Jingfeng <15330273260@189.cn>, javierm@redhat.com,
        daniel@ffwll.ch, vgupta@kernel.org, chenhuacai@kernel.org,
        kernel@xen0n.name, davem@davemloft.net, arnd@arndb.de,
        sam@ravnborg.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, sparclinux@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org
References: <20230510110557.14343-1-tzimmermann@suse.de>
 <20230510110557.14343-2-tzimmermann@suse.de>
 <0e13efbf-9a48-6e70-fdf3-8290f28c6dc7@189.cn>
 <a2315b9a-0747-1f0f-1f0a-1c6773931db4@suse.de>
 <15fe1489-f0fa-bbf6-ec08-a270bd4f1559@gmx.de>
 <CAMuHMdX8piLhEbV+pcWvdn1OEGH9N5FwDOQcqNcEjBx3=ThjXA@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <CAMuHMdX8piLhEbV+pcWvdn1OEGH9N5FwDOQcqNcEjBx3=ThjXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Foe+rnRUWx1zv0MsG5wa8oCmb8hm03NsqOLRkbJVE8zj+/xiq0n
 b8NpDWKOWKr9xolj9cXeyt/T+2KXVc+HBhP9wcESOcxgTnp++n2tJaucjr7D+/zoK7VMQti
 KgeWtm2+Tyy+WBdpRQUwT+L76AN1GzxRgmvzGt5+Gou4Kc1On99MIFqlFqvuu2oSD/7mW4c
 P96Km7cNwRsSxhlrlQlPw==
UI-OutboundReport: notjunk:1;M01:P0:tRn2ltmsACE=;nl+rb0eZLjTlsBi8ry+FawmYWr4
 Ba0MjNp33t95BTJ76lIn3rM5Kg3q/0x6zrbrMvOMegKnxQSsu1sgwN/vdv27yHDuJUELb5pug
 MJu72pXO7s22JdtaHCIWzasuYXuCYNcJBFH66c/jUBJHrXB5VNEG7TjcBE6azIQWviyRNT8t+
 ZCCyS9CdugrTXvTUW5AExeXyRtZUqcZU7jOaxdUwueZGlFBGmHl72zRBQ3p/J28tU4mcJOr4O
 N7MpSHY8mrzhlgBNig8FMlAEB00JzY4r14I29xksd7QkyB6S/xxiFGBVEm8+XvE37ZJ4us4Dz
 jPMZo28GQR77BwNisX0d+C+zqt24+KbMZouWbmTwH7F941TB95mO8NdWt2oqFCl0uBiDXS5al
 HUZ62VBwQDFzd9SA1l9IUuZCEAgtADr/rgCvMGaQ6OHhS8IwyHcSIgYBuV3BFULyeocIp68mj
 UelAQzpsTVpy6bSrQUFdFL0EfxGxePbi9zAxuAhP+ThrwlZnCdf4+3vsm2LQ7ZDc+OpLX9t1O
 6Hs+B1Ky8MfwsTH1E9WlXc7HudPh1PK0az73mKVUNc+mb5MDI4kWWQO2oiXMpF5U2h5z3K35f
 RgtVTiLSaiWwlI0YupqlfTVnqg48qpHm8VE2gY0wr/DXJIIXNVdgva/fKoQMLlxiJhTkAf4aE
 ifOCYRFAp0U82332QQea44OgHIKN0yYvCGJ9omilyJYOGm8RMQDdtsd81cZ6Lk66FC87c/kVu
 xwNRKIgSqx1Uuhqww/OMPuIew86pIFTJ6cUteHtf22IPFsmpMj/IPb+JcNcVsPC7lhijAPCO3
 VRFT3fzCegDlqDFfyJdeJyNW3mQHBkstK0RP0TiWt3jAxBnFO1bS64WYtJFqxsomnTaiwnpvB
 Ct21SREXi+2+KHqH2ZbMUiHNt/aVwy0WLa+p4cWihWh8+y2ydMRbGHrerl1Vn6278Ex9QZQrL
 hxk5vQuzgTF7FoByk3utstkJDUw=
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/11/23 15:10, Geert Uytterhoeven wrote:
> Hi Helge,
>
> On Thu, May 11, 2023 at 3:05=E2=80=AFPM Helge Deller <deller@gmx.de> wro=
te:
>> On 5/11/23 09:55, Thomas Zimmermann wrote:
>>> But the work I do within fbdev is mostly for improving DRM.
>>
>> Sure.
>>
>>> For the
>>> other issues in this file, I don't think that matroxfb should even be
>>> around any longer. Fbdev has been deprecated for a long time. But a
>>> small number of drivers are still in use and we still need its
>>> framebuffer console. So someone should either put significant effort
>>> into maintaining fbdev, or it should be phased out. But neither is
>>> happening.
>>
>> You're wrong.
>>
>> You don't mention that for most older machines DRM isn't an acceptable
>> way to go due to it's limitations, e.g. it's low-speed due to missing
>> 2D-acceleration for older cards and and it's incapability to change scr=
een
>> resolution at runtime (just to name two of the bigger limitations here)=
.
>> So, unless we somehow find a good way to move such drivers over to DRM
>> (with a set of minimal 2D acceleration), they are still important.
>
> DRM can change resolution at runtime,

Right, sure.

> just not through the fbdev API.

... and sadly the simpledrm-based drivers neither.

> Or do you mean the resolution of the text console, akin to
> "fbset <mode>"?

yes.

> I have to admit I do not know if there is a command
> line tool to do that...

Helge
