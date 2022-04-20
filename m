Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298F7509343
	for <lists+linux-arch@lfdr.de>; Thu, 21 Apr 2022 01:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383038AbiDTXDe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Apr 2022 19:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiDTXDd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Apr 2022 19:03:33 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9B81DA5A
        for <linux-arch@vger.kernel.org>; Wed, 20 Apr 2022 16:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650495646; x=1682031646;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=S3wrcHUGdl9LcKznCHJjFCjAB1oU2LwvM5QjcZA34fY=;
  b=gozbVnpPJwgBvGDoblGcclkYC8NNx5wojtRhKxnOqsDx3+esORbLrw5P
   40borVwJRUEEvGEvpF9UKeqYwsuQ5PtnDVQ+vi5wR7u+C4DNaSOTpdagU
   TNNdzYFpnnI0+CdmkjU+1M6+wAbdQK3CnC9cGQDc0E45UthAXMTZAMr/A
   aqMrqt5BXInZOFBJsOliUdZZfcAWZSU2VGtvawPWbK+ww4JiYXxGdeYbY
   zEyrs3bVkAjmAr2zDiRY1Umz8eWbrF+76IXIOsqj0OG21cUbnkJVK9FwF
   EKQ+ryCKR3Gr9abyoQvUEOj79xP7QIybbv6WfJv2qPtuqSo/rZbedGdha
   A==;
X-IronPort-AV: E=Sophos;i="5.90,276,1643644800"; 
   d="scan'208";a="197264220"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Apr 2022 07:00:44 +0800
IronPort-SDR: 572pLc5uyrTX8wXZN3RtS6xuEeBLLAZceQJcXWI3Dlo+PTi27o6ldt0hfPTTTOEEtgYC7lR+7U
 xnhrkCerefbzqcrR1HvRJuzVzzIUnvp3tJNrf834N/wY93ynmmStG92X4I1L27XJTgFLQkFDXR
 vSAB8+MlTEmyedibKmp/jjh5vTbjxyLQ96WM+XPCjTzW14qLngpe5RWND6ki4+DHTJEntodt1p
 nPDwxX4lLavGmzPJh6KvVyLirBexjtHRvkCX7r+xWCLBJ/3124Y/Q0+z8ZAVZgn6DKsj7sVGPX
 PbsD48rIq76p8swBdKFiHjyd
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Apr 2022 15:31:47 -0700
IronPort-SDR: 8RwDw2UKgyw50ONcc7V2Sw6+D1E0ikNnSSHdTqDDwPAh8UGaadVoohQ1TvtycfO/PZyPv8rDW6
 ZAttlF7VYmm4bNyRvAfEB9nPImtbkbn/VuOw15I1n6kTwphzAnc6DwbRcyssktW+lzvSTN58Oh
 IB+TDJRNG2e9XEgZ1cM4DWYA1btjMtHQj1uexUYufK2F0ZT1crAWCek7jWYZcHFbbbMI4mbwGi
 de7LCIclxu8XFsWcT86zKoZidh6vPIvq03SJLG1FlLqF1VrSx+eLImrOmftQtz14FZTIOGWNqQ
 NHo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Apr 2022 16:00:45 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KkGNq6lvcz1Rwrw
        for <linux-arch@vger.kernel.org>; Wed, 20 Apr 2022 16:00:43 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650495643; x=1653087644; bh=S3wrcHUGdl9LcKznCHJjFCjAB1oU2LwvM5Q
        jcZA34fY=; b=D2NS7tuk1+iRdP2LXEmtP9/6hn5ZwQNV8bhVAXHTm6qx3RZWyL5
        c6jousROa5m5iDPz8KDFGCCqKUQ14/8fXxb+x5u4wqoE3FKSjF+IWh2fzArJDGlV
        kMXNdZ+1bffcohH0WCo3xmyWq10jH8WKZiiMcbDew14H68pdOjH/l9dBXXQK7cp7
        2qRoMSDlhBuTMnFp12RR8hWOc8ro6TqIrFTwNh/5ewrdZ40NPlO35+HNySdfJD5t
        X2iefhTMwwiq2uiGXQOqpmYE8heVo/dam/Wd9BPmhLhdH3v2+kulsKEIZ/XInTdm
        pGPF6aGbXgmmA+zSgg/E4dJvjGh1pWJXsLw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vNb_RS4sHLmw for <linux-arch@vger.kernel.org>;
        Wed, 20 Apr 2022 16:00:43 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KkGNl5hPQz1Rvlx;
        Wed, 20 Apr 2022 16:00:39 -0700 (PDT)
Message-ID: <ff01a3d8-3248-b0cb-2276-6438b995dfea@opensource.wdc.com>
Date:   Thu, 21 Apr 2022 08:00:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] binfmt_flat: Remove shared library support
Content-Language: en-US
To:     Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Niklas.Cassel@wdc.com, Al Viro <viro@zeniv.linux.org.uk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mike Frysinger <vapier@gentoo.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
References: <87levzzts4.fsf_-_@email.froward.int.ebiederm.org>
 <mhng-32cab6aa-87a3-4a5c-bf83-836c25432fdd@palmer-ri-x1c9>
 <20220420165935.GA12207@brightrain.aerifal.cx>
 <202204201044.ACFEB0C@keescook>
 <CAK8P3a2KvK78bbW_5DWKsrxLvKxYDqoCkii-kxi-mB7W9DCvNA@mail.gmail.com>
 <20220420202321.GD7074@brightrain.aerifal.cx>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220420202321.GD7074@brightrain.aerifal.cx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/21/22 05:23, Rich Felker wrote:
> On Wed, Apr 20, 2022 at 10:04:32PM +0200, Arnd Bergmann wrote:
>> On Wed, Apr 20, 2022 at 7:47 PM Kees Cook <keescook@chromium.org> wrote:
>>>
>>> Yeah, I was trying to understand why systems were using binfmt_flat and
>>> not binfmt_elf, given the mention of elf2flat -- is there really such a
>>> large kernel memory footprint savings to be had from removing
>>> binfmt_elf?
>>
>> I think the main reason for using flat binaries is nommu support on
>> m68k, xtensa and risc-v. The regular binfmt_elf support requires
>> an MMU, and the elf-fdpic variant is only available for arm and sh
>> at this point (the other nommu architectures got removed over time).
> 
> I believe I made the elf-fdpic loader so that it's capable of loading
> normal non-fdpic elf files on nommu (1bde925d23), unless somebody
> broke that. I also seem to recall that capability being added to the
> main elf loader later.

Last time I checked, building shared libraries usable with nommu riscv
required gcc/ld options that were not supported for riscv (PIE related
stuff). So removing the kernel support for shared flat libs is fine with me.


-- 
Damien Le Moal
Western Digital Research
