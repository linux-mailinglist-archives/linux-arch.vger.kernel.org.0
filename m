Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C30712640E
	for <lists+linux-arch@lfdr.de>; Thu, 19 Dec 2019 14:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfLSNzL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Dec 2019 08:55:11 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:36985 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfLSNzL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Dec 2019 08:55:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1576763707;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=kI2ukjRy7KCFsfSWtfjMgsGPbi2sbVneeGOg1X7LIV8=;
        b=YEAUceQn6QazfdesBsc7kq7wu32oddWtG0x8ZFzA5SAgf87tCs5MuSXc6cVDqJV8Sk
        Ip8uc7MpD9C59eNDNRS2/GUMdq/wRKSLq8HV8w8d+R2aoGrHjvvFrzLo9dxYDGGn4Gmu
        RX2vBgyamQmvkk4LCowX5Ipd7N+bty58IQzSz/Tw2F9UiNJAA0k1h6Rowya8EAdfAf0q
        5UbK3cv9ZS6ZAN9ymq0HmSPVczYFkKF69rHfmWA3KCUSAuVrOlGoiYsLnuIEX9rruluG
        ey6mCVbWjsjMjX+HZmEVgqHavhfdvU/8kqRGWzapHDIZIveK3qyJIvivI3+uu64Mm6DH
        7fkw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPhSIk4IhhIsapUrtwdiemkXf6zUCQ=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:141e:1690:4104:28ad]
        by smtp.strato.de (RZmta 46.1.1 AUTH)
        with ESMTPSA id 40080evBJDsS14t
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 19 Dec 2019 14:54:28 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christoph Hellwig <hch@lst.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, "R.T.Dickinson" <rtd2@xtra.co.nz>,
        "contact@a-eon.com" <contact@a-eon.com>,
        mad skateman <madskateman@gmail.com>,
        Darren Stevens <darren@stevens-zone.net>
References: <20181114082314.8965-1-hch@lst.de> <20181127074253.GB30186@lst.de>
 <87zhttfonk.fsf@concordia.ellerman.id.au>
 <535776df-dea3-eb26-6bf3-83f225e977df@xenosoft.de>
Message-ID: <ea5433f6-ef8d-3cd0-0645-dd89c4806dca@xenosoft.de>
Date:   Thu, 19 Dec 2019 14:54:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <535776df-dea3-eb26-6bf3-83f225e977df@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi All,

We still have some issues with PCI cards in our FSL P5020 and P5040 
systems since the DMA mapping updates. [1, 2]

We have to limit the RAM to 3500MB for some problematic PCI cards. 
(kernel boot argument 'mem=3500M')

The problematic DMA mapping code was added with the PowerPC updates 
4.21-1 to the official kernel source code last year. [3]

We have created a bug report. [4]

The old 4.x kernels aren't affected because they use the old DMA code.

Please check the new DMA code again.

Thanks,
Christian

[1] 
http://forum.hyperion-entertainment.com/viewtopic.php?f=58&p=49486#p49486
[2] 
http://forum.hyperion-entertainment.com/viewtopic.php?f=58&t=4349&start=50#p49099
[3] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8d6973327ee84c2f40dd9efd8928d4a1186c96e2
[4] https://bugzilla.kernel.org/show_bug.cgi?id=205201


On 28 November 2018 at 4:55 pm, Christian Zigotzky wrote:
> On 28 November 2018 at 12:05PM, Michael Ellerman wrote:
>> Nothing specific yet.
>>
>> I'm a bit worried it might break one of the many old obscure platforms
>> we have that aren't well tested.
>>
> Please don't apply the new DMA mapping code if you don't be sure if it 
> works on all supported PowerPC machines. Is the new DMA mapping code 
> really necessary? It's not really nice, to rewrote code if the old 
> code works perfect. We must not forget, that we work for the end 
> users. Does the end user have advantages with this new code? Is it 
> faster? The old code works without any problems. I am also worried 
> about this code. How can I test this new DMA mapping code?
>
> Thanks
>
>

