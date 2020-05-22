Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FCD1DE529
	for <lists+linux-arch@lfdr.de>; Fri, 22 May 2020 13:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbgEVLPV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 May 2020 07:15:21 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5935 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728657AbgEVLPE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 May 2020 07:15:04 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec7b3a50001>; Fri, 22 May 2020 04:12:37 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 22 May 2020 04:15:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 22 May 2020 04:15:03 -0700
Received: from [10.40.101.63] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 22 May
 2020 11:14:56 +0000
From:   Nikhil Mahale <nmahale@nvidia.com>
Subject: Re: [PATCH v6 09/10] arm64: efi: Export screen_info
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Michael Kelley <mikelley@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        gregkh <gregkh@linuxfoundation.org>,
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
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
 <1584200119-18594-10-git-send-email-mikelley@microsoft.com>
 <CAK8P3a1YUjhaVUmjVC2pCoTTBTU408iN44Q=QZ0RDz8rmzJisQ@mail.gmail.com>
 <MW2PR2101MB10524254D2FE3EFC72329465D7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <CAK8P3a1YCtc3LJ-_3iT90_Srehb96gLHvTXsbJ0wT6NFYCG=TQ@mail.gmail.com>
 <MW2PR2101MB1052E413218D295EF24E5E05D7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <f2b63853-24ae-d6b7-cd43-5792c0d4d31b@nvidia.com>
 <4202ea20-6e51-31d3-44b1-3861798a8158@nvidia.com>
 <CAMj1kXEpryfqk5eKxB5NrDcriEBRQKEHnDVZNBMfB4DY=708fw@mail.gmail.com>
X-Nvconfidentiality: Public
Message-ID: <e8850c9b-965a-9ed4-fb22-f41de5f72b60@nvidia.com>
Date:   Fri, 22 May 2020 16:44:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXEpryfqk5eKxB5NrDcriEBRQKEHnDVZNBMfB4DY=708fw@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590145957; bh=D+sxm7QyezSTd/6mnrR3Kj9TgO+UsRoNxeWl9ewZiu0=;
        h=X-PGP-Universal:From:Subject:To:CC:References:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=muq4rwqxalZ5FKQF8c5wHjaw5/TQNGBmGja2Z1j0zLORzHkTBISY23J0YG3XtuyWx
         MQAJmBVqg2minxlYHkoTNvpFjWrgHyD8kwsOijHKn8G+Zb7MyZ0kBd93JRl8GmlDth
         mSaFINv8vXykIucTchvY/pX3jSH7jYJ4Sa4WSDgEFNsGseuw/0N0llHdhgU/GChvrC
         /c2hJ0ZDtIZb9YvKGSQMB7r0miF0B7/yU1CSUccms3VAEjyrpuf/iDmPbnq3YC2Nl2
         siZbZH6yCSWCs+yo8rzhX3EmxitkFm+9l1cEcliR8+tf3McMwuU1LYnMIYMwWO8xbf
         CN3IVXKH0GvHQ==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/18/20 6:21 PM, Ard Biesheuvel wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Mon, 18 May 2020 at 06:25, Nikhil Mahale <nmahale@nvidia.com> wrote:
>>
>> On 5/13/20 7:56 PM, Nikhil Mahale wrote:
>>> On 3/20/20 3:16 AM, Michael Kelley wrote:
>>>> From: Arnd Bergmann <arnd@arndb.de> Sent: Wednesday, March 18, 2020 2:27 AM
>>>>>
>>>>> On Wed, Mar 18, 2020 at 1:18 AM Michael Kelley <mikelley@microsoft.com> wrote:
>>>>>> From: Arnd Bergmann <arnd@arndb.de>
>>>>>>> On Sat, Mar 14, 2020 at 4:36 PM Michael Kelley <mikelley@microsoft.com> wrote:
>>>>>>>>
>>>>>>>> The Hyper-V frame buffer driver may be built as a module, and
>>>>>>>> it needs access to screen_info. So export screen_info.
>>>>>>>>
>>>>>>>> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
>>>>>>>
>>>>>>> Is there any chance of using a more modern KMS based driver for the screen
>>>>>>> than the old fbdev subsystem? I had hoped to one day completely remove
>>>>>>> support for the old CONFIG_VIDEO_FBDEV and screen_info from modern
>>>>>>> architectures.
>>>>>>>
>>>>>>
>>>>>> The current hyperv_fb.c driver is all we have today for the synthetic Hyper-V
>>>>>> frame buffer device.  That driver builds and runs on both ARM64 and x86.
>>>>>>
>>>>>> I'm not knowledgeable about video/graphics drivers, but when you
>>>>>> say "a more modern KMS based driver", are you meaning one based on
>>>>>> DRM & KMS?  Does DRM make sense for a "dumb" frame buffer device?
>>>>>> Are there any drivers that would be a good pattern to look at?
>>>>>
>>>>> It used to be a lot harder to write a DRM driver compared to an fbdev
>>>>> driver, but this has changed to the opposite over the years.
>>>>>
>>>>> A fairly minimal example would be drivers/gpu/drm/pl111/pl111_drv.c
>>>>> or anything in drivers/gpu/drm/tiny/, but you may want to look at the
>>>>> other hypervisor platforms first, i.e drivers/gpu/drm/virtio/virtgpu_drv.c,
>>>>> drivers/gpu/drm/vmwgfx/vmwgfx_drv.c, drivers/gpu/drm/xen/xen_drm_front.c,
>>>>> drivers/gpu/drm/qxl/qxl_drv.c, and drivers/gpu/drm/bochs/bochs_drv.c.
>>>>>
>>>>
>>>> Thanks for the pointers, especially for the other hypervisors.
>>>>
>>> Sorry if anybody in 'to' or 'cc' is receiving this reply multiple times.
>>> I had configured by email client incorrectly to reply.
>>>
>>> screen_info is still useful with a modern KMS-based driver.  It exposes
>>> the mode parameters that the GOP driver chose.  This information is
>>> needed to implement seamless or glitchless boot, by both ensuring that
>>> the scanout parameters don't change and being able to read back the
>>> scanout image to populate the initial contents of the new surface.
>>>
>>> This works today on arches which implement (U)EFI and export
>>> screen_info, including x86 and powerpc, but doesn't work on arm or
>>> arm64.  As arm64 systems that implement UEFI with real GOP drivers
>>> become more prevalent, it would be nice to be have these features there
>>> as well.
>>
>> In addition to this, even if a driver doesn't implement a framebuffer
>> console, or if it does but has an option to disable it, the driver still
>> needs to know whether the EFI console is using resources on the GPU so
>> it can avoid clobbering them. For example screen_info provides information
>> like offset and size of EFI console, using this information driver can
>> reserve memory used by console and prevent corruption on it.
>>
>> I think arm64 should export screen_info.
>>
> 
> If there are reasons why KMS or fbdev drivers may need to access the
> information in screen_info, it should be exported. I don't think that
> is under debate here.
> 

Hi Ard, thanks for your feedback. If my understanding is correct,
you are agree to export screen_info. Can you provide guidance on how can
we proceed here? are you willing to accept this current patch as-is or
would you like me to re-submit the patch with the additional rationale
provided?

Thanks,
Nikhil Mahale
