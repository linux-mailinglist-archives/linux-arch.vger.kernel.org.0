Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649486FEEB6
	for <lists+linux-arch@lfdr.de>; Thu, 11 May 2023 11:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237644AbjEKJYs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 May 2023 05:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237507AbjEKJY0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 May 2023 05:24:26 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4777093FF;
        Thu, 11 May 2023 02:24:18 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.43:41672.1278492290
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id A55DC102960;
        Thu, 11 May 2023 17:24:14 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-85667d6c59-fm8l8 with ESMTP id 5b86e81d35b5461da10c14d4d6e27d84 for tzimmermann@suse.de;
        Thu, 11 May 2023 17:24:17 CST
X-Transaction-ID: 5b86e81d35b5461da10c14d4d6e27d84
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <70c03ea4-c863-d3f7-c057-421f31c57238@189.cn>
Date:   Thu, 11 May 2023 17:24:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 1/6] fbdev/matrox: Remove trailing whitespaces
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        geert@linux-m68k.org, javierm@redhat.com, daniel@ffwll.ch,
        vgupta@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
        davem@davemloft.net, James.Bottomley@HansenPartnership.com,
        arnd@arndb.de, sam@ravnborg.org
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org
References: <20230510110557.14343-1-tzimmermann@suse.de>
 <20230510110557.14343-2-tzimmermann@suse.de>
 <0e13efbf-9a48-6e70-fdf3-8290f28c6dc7@189.cn>
 <a2315b9a-0747-1f0f-1f0a-1c6773931db4@suse.de>
Content-Language: en-US
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <a2315b9a-0747-1f0f-1f0a-1c6773931db4@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi

On 2023/5/11 15:55, Thomas Zimmermann wrote:
> Hi
>
> Am 10.05.23 um 20:20 schrieb Sui Jingfeng:
>> Hi, Thomas
>>
>>
>> I love your patch, yet something to improve:
>>
>>
>> On 2023/5/10 19:05, Thomas Zimmermann wrote:
>>> Fix coding style. No functional changes.
>>>
>>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>>> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>>> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
>>> Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>
>>> Tested-by: Sui Jingfeng <suijingfeng@loongson.cn>
>>> ---
>>>   drivers/video/fbdev/matrox/matroxfb_accel.c | 6 +++---
>>>   drivers/video/fbdev/matrox/matroxfb_base.h  | 4 ++--
>>>   2 files changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/video/fbdev/matrox/matroxfb_accel.c 
>>> b/drivers/video/fbdev/matrox/matroxfb_accel.c
>>> index 9cb0685feddd..ce51227798a1 100644
>>> --- a/drivers/video/fbdev/matrox/matroxfb_accel.c
>>> +++ b/drivers/video/fbdev/matrox/matroxfb_accel.c
>>> @@ -88,7 +88,7 @@
>>>   static inline void matrox_cfb4_pal(u_int32_t* pal) {
>>>       unsigned int i;
>>> -
>>> +
>>>       for (i = 0; i < 16; i++) {
>>>           pal[i] = i * 0x11111111U;
>>>       }
>>> @@ -96,7 +96,7 @@ static inline void matrox_cfb4_pal(u_int32_t* pal) {
>>>   static inline void matrox_cfb8_pal(u_int32_t* pal) {
>>>       unsigned int i;
>>> -
>>> +
>>>       for (i = 0; i < 16; i++) {
>>>           pal[i] = i * 0x01010101U;
>>>       }
>>> @@ -482,7 +482,7 @@ static void matroxfb_1bpp_imageblit(struct 
>>> matrox_fb_info *minfo, u_int32_t fgx,
>>>               /* Tell... well, why bother... */
>>>               while (height--) {
>>>                   size_t i;
>>> -
>>> +
>>>                   for (i = 0; i < step; i += 4) {
>>>                       /* Hope that there are at least three readable 
>>> bytes beyond the end of bitmap */
>>> fb_writel(get_unaligned((u_int32_t*)(chardata + i)),mmio.vaddr);
>>> diff --git a/drivers/video/fbdev/matrox/matroxfb_base.h 
>>> b/drivers/video/fbdev/matrox/matroxfb_base.h
>>> index 958be6805f87..c93c69bbcd57 100644
>>> --- a/drivers/video/fbdev/matrox/matroxfb_base.h
>>> +++ b/drivers/video/fbdev/matrox/matroxfb_base.h
>>> @@ -301,9 +301,9 @@ struct matrox_altout {
>>>       int        (*verifymode)(void* altout_dev, u_int32_t mode);
>>>       int        (*getqueryctrl)(void* altout_dev,
>>>                       struct v4l2_queryctrl* ctrl);
>>
>> Noticed that there are plenty of coding style problems in 
>> matroxfb_base.h,
>>
>> why you only fix a few of them?   Take this two line as an example, 
>> shouldn't
>>
>> they be fixed also as following?
>
> I configured my text editor to remove trailing whitespaces 
> automatically. That keeps my own patches free of them.  But the editor 
> removes all trailing whitespaces, including those that have been there 
> before. If I encounter such a case, I split out the whitespace fix and 
> submit it separately.
>
> But the work I do within fbdev is mostly for improving DRM. For the 
> other issues in this file, I don't think that matroxfb should even be 
> around any longer. Fbdev has been deprecated for a long time. But a 
> small number of drivers are still in use and we still need its 
> framebuffer console. So someone should either put significant effort 
> into maintaining fbdev, or it should be phased out. But neither is 
> happening.
>
Ok, no problem, that sound fine and reasonable then.

The lines being modified has trailing whitespaces.

And I tested your patch again last night on loongarch and mips platform.

It still works in my testing case.

> Best regards
> Thomas
>
>>
>>
>>       int        (*verifymode)(void *altout_dev, u_int32_t mode);
>>       int        (*getqueryctrl)(void *altout_dev,
>>                       struct v4l2_queryctrl *ctrl);
>>
>>
>>> -    int        (*getctrl)(void* altout_dev,
>>> +    int        (*getctrl)(void *altout_dev,
>>>                      struct v4l2_control* ctrl);
>>> -    int        (*setctrl)(void* altout_dev,
>>> +    int        (*setctrl)(void *altout_dev,
>>>                      struct v4l2_control* ctrl);
>>>   };
>
