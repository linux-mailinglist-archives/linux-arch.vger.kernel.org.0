Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D9424C49F
	for <lists+linux-arch@lfdr.de>; Thu, 20 Aug 2020 19:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbgHTRgf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Aug 2020 13:36:35 -0400
Received: from zimbra.cs.ucla.edu ([131.179.128.68]:58964 "EHLO
        zimbra.cs.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729122AbgHTRge (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Aug 2020 13:36:34 -0400
X-Greylist: delayed 529 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Aug 2020 13:36:34 EDT
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id 62CA41600BA;
        Thu, 20 Aug 2020 10:27:45 -0700 (PDT)
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id fqBvGqGGsqCY; Thu, 20 Aug 2020 10:27:44 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id 4A6931600C3;
        Thu, 20 Aug 2020 10:27:44 -0700 (PDT)
X-Virus-Scanned: amavisd-new at zimbra.cs.ucla.edu
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id czr4fMxPxEDZ; Thu, 20 Aug 2020 10:27:44 -0700 (PDT)
Received: from [192.168.1.9] (cpe-75-82-69-226.socal.res.rr.com [75.82.69.226])
        by zimbra.cs.ucla.edu (Postfix) with ESMTPSA id C5F3A1600BA;
        Thu, 20 Aug 2020 10:27:43 -0700 (PDT)
Subject: Re: [PATCH v7 29/29] arm64: mte: Add Memory Tagging Extension
 documentation
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arch@vger.kernel.org,
        Richard Earnshaw <Richard.Earnshaw@arm.com>, nd@arm.com,
        libc-alpha@sourceware.org, Will Deacon <will@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
        Matthew Malcomson <Matthew.Malcomson@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20200727163634.GO7127@arm.com> <20200728110758.GA21941@arm.com>
 <20200728145350.GR7127@arm.com> <20200728195957.GA31698@gaia>
 <20200803124309.GC14398@arm.com> <20200807151906.GM6750@gaia>
 <20200810141309.GK14398@arm.com> <20200811172038.GB1429@gaia>
 <20200812124520.GP14398@arm.com>
 <20200819095453.GA86@DESKTOP-O1885NU.localdomain>
 <20200820164313.GL29343@arm.com>
From:   Paul Eggert <eggert@cs.ucla.edu>
Autocrypt: addr=eggert@cs.ucla.edu; prefer-encrypt=mutual; keydata=
 LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgptUUlOQkV5QWNtUUJFQURB
 QXlIMnhvVHU3cHBHNUQzYThGTVpFb243NGRDdmM0K3ExWEEySjJ0QnkycHdhVHFmCmhweHhk
 R0E5Smo1MFVKM1BENGJTVUVnTjh0TFowc2FuNDdsNVhUQUZMaTI0NTZjaVNsNW04c0thSGxH
 ZHQ5WG0KQUF0bVhxZVpWSVlYL1VGUzk2ZkR6ZjR4aEVtbS95N0xiWUVQUWRVZHh1NDd4QTVL
 aFRZcDVibHRGM1dZRHoxWQpnZDdneDA3QXV3cDdpdzdlTnZub0RUQWxLQWw4S1lEWnpiRE5D
 UUdFYnBZM2VmWkl2UGRlSStGV1FONFcra2doCnkrUDZhdTZQcklJaFlyYWV1YTdYRGRiMkxT
 MWVuM1NzbUUzUWpxZlJxSS9BMnVlOEpNd3N2WGUvV0szOEV6czYKeDc0aVRhcUkzQUZINmls
 QWhEcXBNbmQvbXNTRVNORnQ3NkRpTzFaS1FNcjlhbVZQa25qZlBtSklTcWRoZ0IxRApsRWR3
 MzRzUk9mNlY4bVp3MHhmcVQ2UEtFNDZMY0ZlZnpzMGtiZzRHT1JmOHZqRzJTZjF0azVlVThN
 Qml5Ti9iClowM2JLTmpOWU1wT0REUVF3dVA4NGtZTGtYMndCeHhNQWhCeHdiRFZadWR6eERa
 SjFDMlZYdWpDT0pWeHEya2wKakJNOUVUWXVVR3FkNzVBVzJMWHJMdzYrTXVJc0hGQVlBZ1Jy
 NytLY3dEZ0JBZndoUEJZWDM0blNTaUhsbUxDKwpLYUhMZUNMRjVaSTJ2S20zSEVlQ1R0bE9n
 N3haRU9OZ3d6TCtmZEtvK0Q2U29DOFJSeEpLczhhM3NWZkk0dDZDCm5yUXp2SmJCbjZneGRn
 Q3U1aTI5SjFRQ1lyQ1l2cWwyVXlGUEFLK2RvOTkvMWpPWFQ0bTI4MzZqMXdBUkFRQUIKdENC
 UVlYVnNJRVZuWjJWeWRDQThaV2RuWlhKMFFHTnpMblZqYkdFdVpXUjFQb2tDUGdRVEFRSUFL
 QVVDVElCeQpaQUliQXdVSkVzd0RBQVlMQ1FnSEF3SUdGUWdDQ1FvTEJCWUNBd0VDSGdFQ0Y0
 QUFDZ2tRN1pmcERtS3FmalJSCkd3LytJajAzZGhZZllsL2dYVlJpdXpWMWdHcmJIayt0bmZy
 SS9DN2ZBZW9GelE1dFZnVmluU2hhUGtabzBIVFAKZjE4eDZJREVkQWlPOE1xbzF5cDBDdEht
 ekdNQ0o1MG80R3JnZmpscjZnLyt2dEVPS2JobGVzek4yWHBKdnB3TQoyUWdHdm4vbGFUTFV1
 OFBIOWFSV1RzN3FKSlpLS0tBYjRzeFljOTJGZWhQdTZGT0QwZERpeWhsREFxNGxPVjJtCmRC
 cHpRYmlvam9aelFMTVF3anBnQ1RLMjU3MmVLOUVPRVF5U1VUaFhyU0l6NkFTZW5wNE5ZVEZI
 czl0dUpRdlgKazlnWkRkUFNsM2JwKzQ3ZEd4bHhFV0xwQklNN3pJT053NGtzNGF6Z1Q4bnZE
 WnhBNUlaSHR2cUJsSkxCT2JZWQowTGU2MVdwMHkzVGxCRGgycWRLOGVZTDQyNlc0c2NFTVN1
 aWc1Z2I4T0F0UWlCVzZrMnNHVXh4ZWl2OG92V3U4CllBWmdLSmZ1b1dJK3VSbk1FZGRydVk4
 SnNvTTU0S2FLdlppa2tLczJiZzFuZHRMVnpIcEo2cUZaQzdRVmplSFUKaDYvQm1ndmRqV1Ba
 WUZUdE4rS0E5Q1dYM0dRS0tnTjN1dTk4OHl6bkQ3TG5COThUNEVVSDFIQS9HbmZCcU1WMQpn
 cHpUdlBjNHFWUWluQ21Ja0VGcDgzemwrRzVmQ2pKSjNXN2l2ekNuWW80S2hLTHBGVW05N29r
 VEtSMkxXM3haCnpFVzRjTFNXTzM4N01USzNDekRPeDVxZTZzNGE5MVp1Wk0vai9UUWRUTERh
 cU5uODNrQTRIcTQ4VUhYWXhjSWgKK05kOGsvM3c2bEZ1b0swd3JPRml5d2pMeCswdXI1am1t
 YmVjQkdIYzF4ZGhBRkc1QWcwRVRJQnlaQUVRQUthRgo2NzhUOXd5SDR3alRyVjFQejNjREVv
 U25WLzBaVXJPVDM3cDFkY0d5ai9JWHExeDY3MEhSVmFoQW1rMHNacFljCjI1UEY5RDVHUFlI
 RldsTmp1UFU5NnJEbmRYQjNoZWRtQlJoTGRDNGJBWGpJNERWK2JtZFZlK3EvSU1ubFpSYVYK
 bG05RWlNQ1ZBUjZ3MTNzUmV1N3FYa1c5cjNSd1kyQXpYc2twL3RBZTRCUktyMVptYnZpMm5i
 blE2ZXBFQzQycgpSYngwQjFFaGpiSVFaNUpIR2syNGlQVDdMZEJnbk5tb3M1d1lqendObGtN
 UUQ1VDBZZHpoazdKK1V4d0E1bTQ2Cm1PaFJEQzJyRlYvQTBnbTVUTHk4RFhqdi9Fc2M0Z1lu
 WWFpNlNRcW5VRVZoNUx1VjhZQ0pCbmlqcytUaXc3MXgKMWljbW42eEdJNDVFdWdKT2dlYyty
 THlwWWdwVnA0eDBISTVUODhxQlJZQ2t4SDNLZzhRbytFV05BOUE0TFJROQpEWDhuam9uYTBn
 ZjBzMDN0b2NLOGtCTjY2VW9xcVB0SEJuYzRlTWdCeW1DZmxLMTJlS2ZkMllZeG55ZzljWmF6
 CldBNVZzbHZUeHBtNzZoYmc1b2lBRUgvVmcvOE14SHlBblBoZnJnd3lQcm1KRWNWQmFmZHNw
 Sm5ZUXhCWU5jbzIKTEZQSWhsT3ZXaDhyNGF0K3MrTTNMYjI2b1VUY3psZ2RXMVNmM1NEQTc3
 Qk1SbkYwRlF5RSs3QXpWNzlNQk40eQpraXFhZXpReHRhRjFGeS90dmtoZmZTbzh1K2R3RzBF
 Z0poK3RlMzhnVGNJU1ZyMEdJUHBsTHo2WWhqcmJIclBSCkYxQ041VXVMOURCR2p4dU4zNVJM
 TlZFZnRhNlJVRmxSNk5jdFRqdnJBQkVCQUFHSkFpVUVHQUVDQUE4RkFreUEKY21RQ0d3d0ZD
 UkxNQXdBQUNna1E3WmZwRG1LcWZqU3JIQS8rS3pBS3ZUeFJoQTlNV05MeEl5SjdTNXVKMTZn
 cwpUM29DalpyQktHRWhLTU9HWDRPMEdBNlZPRXJ5TzdRUkNDWWFoM294U0czOElBbk5laXdK
 WGdVOUJ6a2s4NVVHCmJQRWQ3SEdGL1ZTZUhDUXdXb3U2anFVRFRTRHZuOVloTlRkRzBLWFBN
 NzRhQyt4cjJab3cxTzJtaFhpaGdXS0QKMER3KzBMWVBuVU9zUTBLT0Z4SFhYWUhtUnJTMU9a
 UFU1OUJMdmMrVFJoSWhhZlNIS0x3YlhLKzZja2t4Qng2aAo4ejVjY3BHMFFzNGJGaGRGWW5G
 ckVpZURMb0dtbkUyWUxoZFY2c3dKOVZOQ1M2cExpRW9oVDNmbTdhWG0xNXRaCk9JeXpNWmhI
 UlNBUGJsWHhRMFpTV2pxOG9ScmNZTkZ4YzRXMVVScEFrQkNPWUpvWHZRZkQ1TDNscUFsOFRD
 cUQKVXpZeGhIL3RKaGJEZEhycUhINzY3amFEYVRCMStUYWxwLzJBTUt3Y1hOT2Rpa2xHeGJt
 SFZHNllHbDZnOExyYgpzdTlOWkVJNHlMbEh6dWlrdGhKV2d6KzN2WmhWR3lObHQrSE5Jb0Y2
 Q2pETDJvbXU1Y0VxNFJESE00NFFxUGs2Cmw3TzBwVXZOMW1UNEIrUzFiMDhSS3BxbS9mZjAx
 NUUzN0hOVi9waUl2Smx4R0FZejhQU2Z1R0NCMXRoTVlxbG0KZ2RoZDkvQmFiR0ZiR0dZSEE2
 VTQvVDV6cVUrZjZ4SHkxU3NBUVoxTVNLbEx3ZWtCSVQrNC9jTFJHcUNIam5WMApxNUgvVDZh
 N3Q1bVBrYnpTck9MU280cHVqK0lUb05qWXlZSURCV3pobEExOWF2T2ErcnZVam1IdEQzc0ZO
 N2NYCld0a0dvaThidU5jYnk0VT0KPUFMNm8KLS0tLS1FTkQgUEdQIFBVQkxJQyBLRVkgQkxP
 Q0stLS0tLQo=
Organization: UCLA Computer Science Department
Message-ID: <80a8937b-6e48-44ce-221c-84c6d27b211d@cs.ucla.edu>
Date:   Thu, 20 Aug 2020 10:27:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200820164313.GL29343@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/20/20 9:43 AM, Szabolcs Nagy wrote:
> the compat issue with this is existing code
> using pointer top bits which i assume faults
> when dereferenced with the mte checks enabled.
> (although this should be very rare since
> top byte ignore on deref is aarch64 specific.)

Does anyone know of significant aarch64-specific application code that depends 
on top byte ignore? I would think it's so rare (nonexistent?) as to not be worth 
worrying about.

Even in the bad old days when Emacs used pointer top bits for typechecking, it 
carefully removed those bits before dereferencing. Any other reasonably-portable 
application would have to do the same of course.

This whole thing reminds me of the ancient IBM S/360 mainframes that were 
documented to ignore the top 8 bits of 32-bit addresses merely because a single 
model (the IBM 360/30, circa 1965) was so underpowered that it couldn't quickly 
check that the top bits were zero. This has caused countless software hassles 
over the years. Even today, the IBM z-Series hardware and software still 
supports 24-bit addressing mode because of that early-1960s design mistake. See:

Mashey JR. The Long Road to 64 Bits. ACM Queue. 2006-10-10. 
https://queue.acm.org/detail.cfm?id=1165766
