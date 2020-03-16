Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5002418663B
	for <lists+linux-arch@lfdr.de>; Mon, 16 Mar 2020 09:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbgCPIU4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Mar 2020 04:20:56 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:48799 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730034AbgCPIU4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Mar 2020 04:20:56 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MEVqu-1j6Yv62DbW-00G0Hm; Mon, 16 Mar 2020 09:20:54 +0100
Received: by mail-qk1-f180.google.com with SMTP id c145so24591174qke.12;
        Mon, 16 Mar 2020 01:20:54 -0700 (PDT)
X-Gm-Message-State: ANhLgQ25IJsjCF4738PIkgJ2tExxjlDAHAquM/L5EXO1shlp/BalAUv4
        g9OETrClgVxEBs19Y7GPjuSWBJBpRrm5fYr24dA=
X-Google-Smtp-Source: ADFU+vtZkjo0vBQ9aoA74/yqa0lPFIa34VkRS7tbzInZGxQBVX7guZUNzz41ojACEOaEmnmy5gmfBpvemtmAz+Tp3s4=
X-Received: by 2002:a37:b984:: with SMTP id j126mr23717429qkf.3.1584346853152;
 Mon, 16 Mar 2020 01:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com> <1584200119-18594-10-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1584200119-18594-10-git-send-email-mikelley@microsoft.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 16 Mar 2020 09:20:37 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1YUjhaVUmjVC2pCoTTBTU408iN44Q=QZ0RDz8rmzJisQ@mail.gmail.com>
Message-ID: <CAK8P3a1YUjhaVUmjVC2pCoTTBTU408iN44Q=QZ0RDz8rmzJisQ@mail.gmail.com>
Subject: Re: [PATCH v6 09/10] arm64: efi: Export screen_info
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        gregkh <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-hyperv@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>, olaf@aepfle.de,
        Andy Whitcroft <apw@canonical.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jason Wang <jasowang@redhat.com>, marcelo.cerri@canonical.com,
        "K. Y. Srinivasan" <kys@microsoft.com>, sunilmut@microsoft.com,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:3oiE+Otbi3jGoRi0yjnKv95hDDl7bcMuoGX6Dw9D31mFMPeYSYV
 /VFxgUr5NoC+gzUi/shyYcUzhROyvji2QmRVwepKFeCCQSqxBS1FJsQ8iDXSl/dlplv8h3C
 Klt6YPtEyXC4PLvLTD4R1/sdFcz8nqEZ0+GhkUvneACxcHzhz0K0IxUCgZyUcNmgTt0ldpw
 lUHE/Z8cSJ7M/3SZEt7qg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EzFEDNwqUXg=:Te3pPTz/fHgCxcuNS/q6Yd
 b3bjIcurtb42JyNfB/YwiM1+xkT6bCyBSwg63OT00C76m9rLzdWUUVLaaWFPJWo+rXvYC5XNr
 uwSSMlxWYW6l9Oanyd0sPvQk1jTWHy+xUqXRRSkloXo0zYYZaeUAz4Pjx7UtDjF6/5oOKLIpN
 9xMlYC7TyI5Ij0+d9Yh3r4qLyfFvHs6z/7iK4rkusl33pX+AHvhD4sQWvmb/hvYOcrvC/+H0r
 Zgsr5tXFHCNEdd22VZY5yuj9KALnY1fE359j2BeouftK8lvYALNm0a1C4WBK+f5CVa5Wa8Gvj
 Fr4Hm43UshnnC2pISSpr0wvAUzla+n3aCVL1Twn9/WZbAs4cI9eoz+3owPd4MyuHkZxAq7E4r
 qpzAg8hciQkGoeqmmBrS6fezCT/I7kMDtck1Hlogi39OgkJr7+i1K1qxm1vsG1d8EEaxcJ272
 D5N1OubPzk/u8FPxpciaRydt3zi7FTo7NSlWrIW6a0/Ci0UySbdDbGtLmDB2BhK2+CnzPLCNc
 JHoFX5uWIMP1x7EaJuOIroIWftYotzYxnRDAmoUZTqA7yKIJysfIyTZR43MKSUrOa4b5aqa55
 ldIDr2CnZup+fckT7MwA41yyGKcn3vWqAzJ8DItg+HBH+BTRUjAsLjTxf4SoQnQK2dIluuL7U
 MKVukYbKQeFHId1biQroJm6KV4u7zllQ5oa+HUF10WK5m1xYV8QauC+BjCjhkT3rJc3umIvgG
 zBOO0ppvtZW7TBI0K5i1kWzGRcpGb2267RdO24e4TIWUJs3soH8rJfhvA8cUBPlpuax2BHii4
 JfNHzfETBJNSBD3Qp4eqOZbhJ4zvKpmOQNueLRt1E2zaMVNhEY=
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Mar 14, 2020 at 4:36 PM Michael Kelley <mikelley@microsoft.com> wrote:
>
> The Hyper-V frame buffer driver may be built as a module, and
> it needs access to screen_info. So export screen_info.
>
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Is there any chance of using a more modern KMS based driver for the screen
than the old fbdev subsystem? I had hoped to one day completely remove
support for the old CONFIG_VIDEO_FBDEV and screen_info from modern
architectures.

     Arnd
