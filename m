Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58474186653
	for <lists+linux-arch@lfdr.de>; Mon, 16 Mar 2020 09:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbgCPIXD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Mar 2020 04:23:03 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:58117 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729996AbgCPIXD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Mar 2020 04:23:03 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N95qT-1jPBAJ3dQd-016BI8; Mon, 16 Mar 2020 09:23:01 +0100
Received: by mail-qt1-f169.google.com with SMTP id i26so3623539qtq.8;
        Mon, 16 Mar 2020 01:23:00 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3xyfcPRwFSzpeJHpB02bVNYnMix+hqaL2TAx+V5/DHrVCtMDwV
        APA9BSIltVIHF3dEDKrOIaC7gTDksyZLSOuXI2A=
X-Google-Smtp-Source: ADFU+vtvCxAlAeHfmkkAPmp7/hL77mUzkuyTzG3N03DevkjajATYqP8pbnWgan39uFZ96E87M222njLjT5t037hM4uU=
X-Received: by 2002:ac8:6f6e:: with SMTP id u14mr3828514qtv.304.1584346979438;
 Mon, 16 Mar 2020 01:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com> <1584200119-18594-5-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1584200119-18594-5-git-send-email-mikelley@microsoft.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 16 Mar 2020 09:22:43 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2Hnm74aUMNFHbjMr4HwHGZn1+xa4ERsxAJY6hMzhEOhQ@mail.gmail.com>
Message-ID: <CAK8P3a2Hnm74aUMNFHbjMr4HwHGZn1+xa4ERsxAJY6hMzhEOhQ@mail.gmail.com>
Subject: Re: [PATCH v6 04/10] arm64: hyperv: Add memory alloc/free functions
 for Hyper-V size pages
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
X-Provags-ID: V03:K1:rqvFYvTxsNB/VV4Ocr+6BAiwKkIrYd8B02+pZ+Os++8CyuYV2q6
 AHa4ZaI92MwibaXB/GPD6z10SooQtH4JTmEB0orR7G3WmI9D3NSi8e4lKRzk92yuqt+2/1H
 cxWPTsUPyfiwMLwiOnhEDJi3APVLJ3vRulumgKMgqLq+El7+OLjp5eEII1Lf5Xb6cP6TN54
 V9NiW07GxzXvrD4bNGFuw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:v1VISpsAiv8=:+8YnIBomi1CFkBf1trecP1
 x7wAohu20sbMq/WFkqpq7UNc59Qedqyy3k/u2jIa+VUYVF04aeUae9w628Uh/ni1XLnf1UsnO
 cpJJSLxE0HS34dYCKozr8VU31i3eRJ4exNQxIzOxkJg2ZiuWP9pUrgu3YwwU9cC3LLB+f/xK8
 fu2bksv46j9KtS/JVS90rJ9WkI9hL+RCQSm96o6+b8xhwHdzUSr7OwNVYlP3XOHUed/iv2OZu
 Wumm2oKIzlEQlyFg9N2osIyLbYy7ZnT7u54YDF/Zu5vQmEFd/CrWyBUu7E1QwEy0i33e2mFRC
 H+BRwBGknsFFUHBPf/9YFXhlcEHrlS+I3L2gCHa2G9P01DBrMH6lK/gQAMxWp0SQwwUAH3U03
 NGzp77jeD04JjXA6LsEFVc8e4YcVitp+zAo+tXpoVM1//Tx6rU4B7oGEf0E/eTBjus0uoy8x3
 eEtSCGr/PHkJc0NzVLmh5UmfXfNvLcVkrf+6so6B2FTpnwv8I8XtTisj5GUxSR4vLcXmm1poD
 DANLgtR6x3u+RfimdBB9ZldOQxcmujUUn8b69SQxBZLZDZ01v/b+WCJ2Vvtkbypl4msYzVeOr
 QjYCS/ephQzGsswq8z6B+zK+NMMFq6Z79fIZ65EEHsBg2dtVylF4X3Nm74dG7FSnal1tsBvJN
 RUBQDxpa0ZLgWcG/ma8iSL/5Q//J/dj5FVsFec7PP5wyql8K4CoBBkEvO+Akcnk12Qh4xdyj2
 D2gpDjqPGgISdbJPk+Dq2ij8QU+hAX9JlEp15XGwBuLL/jo+D/WkA4xFzcqiCm8ofZaW1Tr+V
 ReIPtGupH3qQkig4TOdrr1KIcIB6NynTkaHB8DcpEt83zRKkkk=
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Mar 14, 2020 at 4:36 PM Michael Kelley <mikelley@microsoft.com> wrote:
>  /*
> + * Functions for allocating and freeing memory with size and
> + * alignment HV_HYP_PAGE_SIZE. These functions are needed because
> + * the guest page size may not be the same as the Hyper-V page
> + * size. We depend upon kmalloc() aligning power-of-two size
> + * allocations to the allocation size boundary, so that the
> + * allocated memory appears to Hyper-V as a page of the size
> + * it expects.
> + *
> + * These functions are used by arm64 specific code as well as
> + * arch independent Hyper-V drivers.
> + */
> +
> +void *hv_alloc_hyperv_page(void)
> +{
> +       BUILD_BUG_ON(PAGE_SIZE <  HV_HYP_PAGE_SIZE);
> +       return kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
> +}
> +EXPORT_SYMBOL_GPL(hv_alloc_hyperv_page);

I don't think there is any guarantee that kmalloc() returns page-aligned
allocations in general. How about using get_free_pages()
to implement this?

       Arnd
