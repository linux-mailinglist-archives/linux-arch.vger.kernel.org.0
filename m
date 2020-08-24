Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703C72507E7
	for <lists+linux-arch@lfdr.de>; Mon, 24 Aug 2020 20:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgHXSjG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 14:39:06 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:55335 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgHXSjF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Aug 2020 14:39:05 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MLAAs-1jtIiT1mMs-00IAPf; Mon, 24 Aug 2020 20:39:03 +0200
Received: by mail-qk1-f174.google.com with SMTP id n129so8413650qkd.6;
        Mon, 24 Aug 2020 11:39:02 -0700 (PDT)
X-Gm-Message-State: AOAM533GoAksagaHXOg4j38Zr377VXxK0VxSW/leHWXNxC6eqapnHM1z
        iG4S79KSG4/p6ImSRNgr5Yn6w61qnwbVzgcHoz4=
X-Google-Smtp-Source: ABdhPJxJvbiLbhFh8vD057RbddB7UEJe4ClqG4b3m1sziovfYqvCJXHcrzaj91rVO8TT5jSK5crxBkQQA/dFlQR8EPo=
X-Received: by 2002:ae9:f106:: with SMTP id k6mr5648402qkg.3.1598294342005;
 Mon, 24 Aug 2020 11:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <1598287583-71762-1-git-send-email-mikelley@microsoft.com> <1598287583-71762-3-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1598287583-71762-3-git-send-email-mikelley@microsoft.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 24 Aug 2020 20:38:45 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0qAZ5nGQ6eEjtAR4MD=CNnkU_uW1PsUdwJiZC1Hy+bpg@mail.gmail.com>
Message-ID: <CAK8P3a0qAZ5nGQ6eEjtAR4MD=CNnkU_uW1PsUdwJiZC1Hy+bpg@mail.gmail.com>
Subject: Re: [PATCH v7 02/10] arm64: hyperv: Add core Hyper-V include files
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
        linux-arch <linux-arch@vger.kernel.org>, wei.liu@kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Lup994B9M/joDDHE/Mn9GCbY8qhexb9qrSZlYAxKE6BIofeZgWB
 AuCK0IbuyDRmWTwrhtMSEbsxr8qLCLryx4/dlzai8FKvB2tiFLSHX19ZKQZvT/LCyHhRS66
 wKp4vFX5WIEX8i94nh+kVNJQFZnnoxH/h8ZKvUfQpN15zLoB6sswHSXLsa6M4MBihzQN4h6
 JW4CWdv7IPsrQu/3FqZEg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wQqH2+rPVXY=:UsQCuOiBUDFWZBRrfbysfm
 7skOXJpB1walSUF2fUxhtp5EUnP55ygZ7Vd/Sx2RKO7n7dZK/QuEG44rhSLId9tvuoISX5IWd
 V8QOW/I5OgI4RkO7tT1/uekPZ+GNifArPLTpo+CpDqhmco0wRvZGrJQmjOu4WB1EHv+CND/a2
 q80zhScWPA0PAmvVpSeoqsDMnMXjzsZHHWD2ettfSq+rxEZ0n1jcCSGBmEIACevgelF/WexNR
 QVGTH484tcoww/JAR8C4qI6Mq8Bb3trKNMHiakeexBAC/crNk56KjrQftP4HDUgpX5PhbcPm+
 MexxDHX6lwsZnEC1nMOR9RvhLl4omy+xafcvHeY6GHJlXfgh9e495UzbM8g5a0VT6bLIA44SN
 B1gL1vVIEc8VGQ8utMt8KeM6YnBgQ4JF16lGAZ/TIjoIfWhkIsRH3Pfr9DyTi4dqsRkzg5+81
 n+X69inUsERA/G1rdfBFZmHHlJpSq4aOR1DyO9bWVadBDqaYX+2nCsLhL8jUNHfO88lS92q6x
 NlRgfO3jub1dnEZaiMVyuh1fTvuGcNGS2QQFfxvOL39uIpyX2NzLkyQr9wd67Kwl+q7EflvGz
 7f8rUOCogjg+WHUNPpqtVX8RxWuPZAsGa4VZ/bAC+QktJnXRzisqsYS7jAVS46vVP/UyRIkQ3
 Vqd6TxqDIUEh0XrAOWB9rcYSelnNpootlrxXSc6R0zILU7WF+4BNtW/gBmm/JZZY/B3TxHT54
 EpT1Lf/glHNsigxH4o5VEO/b0lxgSymqKUKczMnYX7ksR5834F+aMkicrQfVWCFtvxZCzlhLw
 2HxsoWxDUYBAkS2nHVD5fdhOodq8fKH09yV48Jru982XeLVJgQ9Vq5LXluWLpCH8kOLwLFeVF
 Z0zLXKs3KjtSSTu+BRvf0GsZXHufZRC+JJWLdVeoJdchFoWCLOpNP8MfjTzYACePoI824Vb0U
 FS7R/TBvsvIkSEJNwLi+3Z2w4j0/IXYM9Aa/ZFFc2lhspwlhYh8dT
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 24, 2020 at 6:47 PM Michael Kelley <mikelley@microsoft.com> wrote:
> +
> +#define hv_get_simp(val) (val = hv_get_vpreg(HV_REGISTER_SIPP))
> +
> +#define hv_get_siefp(val) (val = hv_get_vpreg(HV_REGISTER_SIFP))

Macros that modify their arguments are generally a bad idea. Since each one
of these only has a few callers, could you just redefine the x86 version to
use function-style calling conventions and turn them into inline functions?

      Arnd
