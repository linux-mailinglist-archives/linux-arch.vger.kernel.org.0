Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED29318D45F
	for <lists+linux-arch@lfdr.de>; Fri, 20 Mar 2020 17:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbgCTQ2l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Mar 2020 12:28:41 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:47719 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbgCTQ2k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Mar 2020 12:28:40 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M4bd0-1jEm0n0TIs-001gHZ; Fri, 20 Mar 2020 17:28:39 +0100
Received: by mail-lj1-f181.google.com with SMTP id o10so7060386ljc.8;
        Fri, 20 Mar 2020 09:28:38 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1lXksRDg3jTxH1KKtFuAVYuecGKuXC9CYNcItFdBPNM5EypR0D
        mxwH6fu9fygVkKi7EYe8BTpg9gbrP93VoADt6II=
X-Google-Smtp-Source: ADFU+vvpQzCbtjOU/ac9luh0iy3YFl0a9lDUyyVpQqCoBSJMe7aSkeTdT1zPnEUT/etuCU6Df1Q0pOh+XidX5WSpNxk=
X-Received: by 2002:a2e:811a:: with SMTP id d26mr5709626ljg.128.1584721718522;
 Fri, 20 Mar 2020 09:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
 <1584200119-18594-5-git-send-email-mikelley@microsoft.com>
 <CAK8P3a2Hnm74aUMNFHbjMr4HwHGZn1+xa4ERsxAJY6hMzhEOhQ@mail.gmail.com>
 <632eb459dbe53a9b69df2a4f030a755b@kernel.org> <CAK8P3a3aihZeriUWAhWJMsOtdiY4Lo29syrRbB4Po3v4dsLhvA@mail.gmail.com>
 <MW2PR2101MB1052D91D3A9CEEBD7E2EA82FD7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <CAK8P3a2AO4k3vJ7WuJQz7ick+XPgGY3Jfk8-ROqtwyNs0nWkDA@mail.gmail.com> <MW2PR2101MB10520CEF065A41EEBC17FFC2D7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB10520CEF065A41EEBC17FFC2D7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 20 Mar 2020 17:28:22 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1MfYDTiQ9j0o3tnd=ymZukPoSmuExLhEMRR+GRwVD7xA@mail.gmail.com>
Message-ID: <CAK8P3a1MfYDTiQ9j0o3tnd=ymZukPoSmuExLhEMRR+GRwVD7xA@mail.gmail.com>
Subject: Re: [PATCH v6 04/10] arm64: hyperv: Add memory alloc/free functions
 for Hyper-V size pages
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Marc Zyngier <maz@kernel.org>, gregkh <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        Andy Whitcroft <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>, Jason Wang <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        KY Srinivasan <kys@microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:YiwlX9iBdiXNg5xNtCEAFPdb1mkadbK81jrmhX7LRdvitySwwNa
 I0MZ8RkloQ6Wlcj6yPAZH3KxYFj9R5P8CijRzmi4IEKMRQ3SC3zrS5uqCGDBDEHOSk0BUGw
 ySjD0RZKR7qkyOKWvFA4tTYRiUyovBuByh3bMx0kN4kQ2pY2R6YP3/gqsSkn9LSJDEGDlqn
 1jKT4lbdm9MH/OxBCNijg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:p2Q7lJ7StFc=:JDSIaW/ZZxeHgXGY3IgFHv
 E7dYB81ADyVZu2ueLhAM6M/33RM6j0PlwdFW3oe8a6v5Ifg30WApd8nxrrQr/a7+eg8IQn2iV
 eLzn+a7Ot5YurHKeqvOKKjW7/s1Ss3BQNIsGrrxDErkTY4ThPFYA0QqYFq4wJcVfRIbWjm/t0
 q6UOU9/W8eFKSN1cWIIWZPuQcyOYijM3HfDXk8A3ZPdeebOzLrx9EzF6qYsmbY5WZG4vdLzS6
 7zqhMtXadOSRlm2KKytTUJkp8lZtsB4skRcEAS9OURpuHqcyIMLeqpqLh31oygHLvXYzqvX3j
 jirgTQbb5E8YKufVnzUFBl50/8Vu/ct8u/mjehvzEJQYnVLmNoCIyHmOUmhul1F/Aeej6wzEW
 /SByQp0/H2S5mmoSlhClYS6d5pvyOF1l+z9woDfb0nSX2yP5cZyMu9sJcN7XfFyHWhwKwRV4g
 66+0FxqiTVrDy13KD3mnCw8cp8c2EVnamWhU0NhhynhLW85raJvFloYscH0lb+l4C/IVsvuDE
 PqfwIiCU6JhTzXxLvHnCBnWN2EW0LvvHLYBBLMBqCZlb6K9eMtqObq7/AIahoH8rzZiZd5/fD
 zEjVbKoc3VeqwIzN2dfVoha57MZ5NjX6cfZSA9+SFKK7qKWBFNckCf9cqKyLnrLKqZc+LTlgd
 rbh7W37ozfk8r++8aYM3kHdGJ2eRMk6Y3NFGlqEuzyZmg85GyO93VyHQuw2hQbk8LYF4F6eEG
 O4E7Rc+g1yCcnL5vyfT+wULZf+LNNZOGrEuwnrW0PVxWc/D7HohvhLTSQ6OjCffx0gQSgZCJG
 dR9naK66fvrP5fTFu1dGR/9upk6iUh6zUNJ0Ki8+p9EJ9ohoiM=
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 19, 2020 at 10:43 PM Michael Kelley <mikelley@microsoft.com> wrote:
> From: Arnd Bergmann <arnd@arndb.de> Sent: Wednesday, March 18, 2020 2:58 AM
> > On Wed, Mar 18, 2020 at 1:15 AM Michael Kelley <mikelley@microsoft.com> wrote:
> > My point was to keep the functions but use alloc_pages() internally,
> > so you can deal with the hypervisor having a larger page size than
> > the guest, which seems to be a more important scenario if I correctly
> > understand the differences between the way Windows and Linux
> > deal with page cache.
>
> OK, I see now what you are getting at.  I should spell out my
> assumption, which is the opposite.  Hyper-V won't have a page
> size other than 4K anytime in the foreseeable future.  The
> code is too wedded to the x86 4K page size, and the host-guest
> interfaces have a lot of implicit assumptions that the page size is
> 4K (unfortunately).  But the last time I looked, RHEL for ARM64 is
> delivered with a 64K page size.  So my assumption is that the only
> combination that really matters is the guest page size being larger
> than the Hyper-V page size.  The other way around just won't
> happen without a major overhaul to Hyper-V, including a rework
> of the guest-host interface.

Ok, got it. We should really ask Red Hat to change the page size,
but as long as you care existing systems, and you expect this to
result in gigabytes of allocation on future systems, having the
wrapper seems reasonable.

Maybe you could fall back to alloc_page when PAGE_SIZE equals
HV_HYP_PAGE_SIZE though? I'm not sure what the tradeoff
between kmalloc and alloc_page is these days, other than the
feeling that alloc_page is the more obvious choice when you know
you always want exactly a page here.

      Arnd
