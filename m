Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706F7562305
	for <lists+linux-arch@lfdr.de>; Thu, 30 Jun 2022 21:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236635AbiF3TWH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Jun 2022 15:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235833AbiF3TWG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Jun 2022 15:22:06 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917CF42EDA;
        Thu, 30 Jun 2022 12:22:05 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id r66so272772pgr.2;
        Thu, 30 Jun 2022 12:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=l005vzshb3NCX9X2VM+PRHsKSH+cwoE8+hpxYOqA4As=;
        b=Ryekk371jQ1QiVX/pYGZ1Fxnqlqp0Twrw4fdw7rwXdWNZd8linJuCpYUZVY+Q0iPyf
         MQtHmLDECOfQliv0UkVXxBpP1oEkjtqBA+m+vXUw7eTKeZQm+pLSA86FeQvRbD+P0G11
         vgeXEKD6isj/F1Ee/eKIdEVU/vkXQM/wI5kbLINfslHCrrzOI44xnSHDUGCbhqvwVddM
         j34tTrE1+UG2QZsXwyPCsEBPg2rxRpPI3L1pBalHzCrfK7rgExkmBMwK3cN5a26ttPxc
         nujxQaN3aRGOZJRNQAC0dUIV+4oE8cjHO5gI3kzVIoJ4RZMsmRwklddwhggK/OvBOGty
         iS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=l005vzshb3NCX9X2VM+PRHsKSH+cwoE8+hpxYOqA4As=;
        b=OZ1vQKOIwXQzF+ihG5piJ2OLW8zgQeKk23bWieZNXHK+d5dt/GTKu2oIWFPKf1rIUx
         o/O185/IDs3/lFjXVK59ptN4UNI3KqRm2TOQK4vBAPokDi2L6d3JtaPrEyecW9Q5x7Um
         +PFkEGfnErMdVrSVBivJynFd1VPL7Cl3K3pnNwgivCTZmR/Um+BFK2/BLDUAd5LolYj2
         h2DOOp9FmD8IOpW33ME78lqFnCef4o+8CeirCCmEuQWRqWhE1aSjhs83AYn7X7kOf4kp
         Q7XXXxzYtBJnhFqIJfw17rct71JBpd/PrtxN2UqaKlEak1/VPmC2Czx9MtqJWtHXCPZq
         cOXg==
X-Gm-Message-State: AJIora9K4nozs8s+qe8k7LWArsdT1riIp9llWiSy+Nrr0LGYf6UkHf44
        ZYPSEhOYB/yAM0jKaVHigJA=
X-Google-Smtp-Source: AGRyM1slOrPQAMr1SPYrSza35gnZ53yO5OmKuyILVUgGuCU6HEAC2pr8Byjfbqxc2GodF/4gt0QEFw==
X-Received: by 2002:a05:6a00:21c8:b0:4fd:f89f:ec0e with SMTP id t8-20020a056a0021c800b004fdf89fec0emr17286632pfj.83.1656616925098;
        Thu, 30 Jun 2022 12:22:05 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:b411:35d2:9458:bbe5? ([2001:df0:0:200c:b411:35d2:9458:bbe5])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902a3cd00b0016403cae7desm13907355plb.276.2022.06.30.12.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 12:22:03 -0700 (PDT)
Message-ID: <c1d245ae-54c3-ec2b-e975-d50f9a863d2b@gmail.com>
Date:   Fri, 1 Jul 2022 07:21:53 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 3/3] arch/*/: remove CONFIG_VIRT_TO_BUS
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Khalid Aziz <khalid@gonehiking.org>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Matt Wang <wwentao@vmware.com>,
        Miquel van Smoorenburg <mikevs@xs4all.net>,
        Mark Salyzyn <salyzyn@android.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Denis Efremov <efremov@linux.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <20220617125750.728590-1-arnd@kernel.org>
 <20220617125750.728590-4-arnd@kernel.org>
 <6ba86afe-bf9f-1aca-7af1-d0d348d75ffc@gmail.com>
 <CAMuHMdVewn0OYA9oJfStk0-+vCKAUou+4Mvd5H2kmrSks1p5jg@mail.gmail.com>
 <b4e5a1c9-e375-63fb-ec7c-abb7384a6d59@gmail.com>
 <9289fd82-285c-035f-5355-4d70ce4f87b0@gmail.com>
 <CAMuHMdXUihTPD9A9hs__Xr2ErfOqkZ5KgCHqm+9HvRf39uS5kA@mail.gmail.com>
 <c30bc9b6-6ccd-8856-dc6b-4e16450dad6f@gmail.com>
 <CAK8P3a1rxEVwVF5U-PO6pQkfURU5Tro1Qp8SPUfHEV9jjWOmCQ@mail.gmail.com>
 <9f812d3d-0fcd-46e6-6d7e-6d4bf66f24ab@gmail.com>
 <YrvvfpW4MmQiM47H@infradead.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <YrvvfpW4MmQiM47H@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Christoph,

On 29/06/22 18:21, Christoph Hellwig wrote:
> On Wed, Jun 29, 2022 at 11:09:00AM +1200, Michael Schmitz wrote:
>> And all SCSI buffers are allocated using kmalloc? No way at all for user
>> space to pass unaligned data?
> Most that you will see actually comes from the page allocator.  But
> the block layer has a dma_alignment limit, and when userspace sends
> I/O that is not properly aligned it will be bounce buffered before
> it it sent to the driver.

That limit is set to L1_CACHE_BYTES on m68k so we're good here.

Thanks,

     Michael


