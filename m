Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559836FF216
	for <lists+linux-arch@lfdr.de>; Thu, 11 May 2023 15:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjEKNF4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 May 2023 09:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjEKNF4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 May 2023 09:05:56 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7301FF2;
        Thu, 11 May 2023 06:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1683810308; i=deller@gmx.de;
        bh=NQqZVO7q0AzD6O3qUHr/zOC6q7eA09+N7H7wJE1dLgo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=IwhEYcVfW0U0V0dlTNp9aXOlVY1SmmwaAnbT7uRf1l1it7kwkmN/5bFxi1r3BvcXI
         4lrcxpFo9mTSqRZMqNKCGzwSgnMsXGvPqkwfq1mpPHMW1X3pi2mqD+Ymlm5ElyfTrO
         F4BcgvgnDCSF0UAeDjWX7XH44qGuhW54Et5madzLYkwP5vx4fUDiGmHgzOwk25PNaC
         NyoUSmPIem5R3pL13+e+1zTkxMe9r1nEvGM7k4Z6/Olq3q5FJ3oNCbJ9I4HC3O4F2s
         BTfHJCfxj23Ojaw3Fux9pJQkHwFt5rTizFIQF6MJRBZ2c98ILBMlabrTmfzuQ6bGl1
         6/XNE2+HV+elA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.77.61] ([109.43.178.145]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwQT9-1qDfYk49Rt-00sMYT; Thu, 11
 May 2023 15:05:08 +0200
Message-ID: <15fe1489-f0fa-bbf6-ec08-a270bd4f1559@gmx.de>
Date:   Thu, 11 May 2023 15:05:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 1/6] fbdev/matrox: Remove trailing whitespaces
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Sui Jingfeng <15330273260@189.cn>, geert@linux-m68k.org,
        javierm@redhat.com, daniel@ffwll.ch, vgupta@kernel.org,
        chenhuacai@kernel.org, kernel@xen0n.name, davem@davemloft.net,
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
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <a2315b9a-0747-1f0f-1f0a-1c6773931db4@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xuEOlcJHM9j74UL03mkKgceEShxgamhjob7lybOe4cSo0vz1X2x
 BVAJGbjak/DT0G0C8FIsSEmPJzCeX1Sr0L3wH0HoDfhOoKuF+A2+4m/Hr4TSOCHpKfhNytZ
 wakn4EPMStBz08AlWasJn2HnXJxm/rmNuYCy4rIrm8xpJ+NPc0wNuaKYFJvLVpxj4mKHDSR
 a3GbIV2wnVdX/HqY8Uhdw==
UI-OutboundReport: notjunk:1;M01:P0:/9D0KbTrXMA=;02q5SnDmGt7rAOe4hQK+ROjDdR2
 pjzMz18/ot1pLTQSwGJMJABUW9hA4sq6VmyKNzZ6Pl7M6j1HowqK0GrjdnxQCB0UHWr9jiwAK
 eZ9s4vh0AaJVq5mIRSXMlP8IBla+2sFu5/0Yt2ebw2wUZfgKSA0kTkRN6sa4biFPKjN+BH0Vt
 QEz6JW1vWVTwirv5roA+wmopZh2hyF6rGME9AaMAYa++4fAvRSOqSM8h5Tt1HT8uDChp33jQu
 /bZPrQSV9U9kkTKmg3F/NNI9DAcoq5zfRMitqLq+mTZf/nAiiy+Cu7zoBKb6bmR54hUsGkucK
 AAUUYP/YLCKJSahYYbAf471k2CoeEvlqW0mUtuGq2sTpyeRDaB7LL19eCAJQD6v6YWfSjjyML
 8h4ItTnLLo+4Dy5ESCEBBJPjjxxwWKxWnqViAZh2s1aGq8ZI8QOtcNc2E8atCD73tJOxyIm5R
 G8MuOyWNFgy5PvXdlyRMvCflHKRdcpzpf7soPm0+VwnZXYckI9uPMGbO+1/h4LAxCkC0Tpm2k
 O76wXCx3k1IUxRQMSQ/QF2hml10A9LARj8VyWpP0sazJQoLLiyxoNKHYXhsH/mXyed2lfSPiB
 noVepWJ9lUbT6yRcqB2fI+1/2e5g7dIYLnHDtswOQRYSx7yp7ZuOTKbIj7bjX5E/yi6Lsvrn9
 /6iIDw5xyHoFeXq10NxvYIJ/qbPygdSi6HrdWjLNM/7GpJekf24KcF6z37GLTrvqEeF9geDQz
 zWF36or0s9iY7CNkIGoUkw4nob8fGPRWAAcYKZTYXhIuGti8jYdJv17hdPmZH46KC9ng9n2x3
 AfMwM3IqdCMfSSw+mhvE8QBFZzme30ua2CzDpgjkvg0Qt1AS1yiAJl7QxN3dyf5KgPNuP+zu5
 zgbmbvXr8gWD1jJqzgd2L/GnNcJGBKw5jn6W0591BeirwUT9Wa1ykM7r7Xt58VSkwhELokBjl
 apc1vQ==
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/11/23 09:55, Thomas Zimmermann wrote:
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
>>> =C2=A0 drivers/video/fbdev/matrox/matroxfb_accel.c | 6 +++---
>>> =C2=A0 drivers/video/fbdev/matrox/matroxfb_base.h=C2=A0 | 4 ++--
>>> =C2=A0 2 files changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/video/fbdev/matrox/matroxfb_accel.c b/drivers/vid=
eo/fbdev/matrox/matroxfb_accel.c
>>> index 9cb0685feddd..ce51227798a1 100644
>>> --- a/drivers/video/fbdev/matrox/matroxfb_accel.c
>>> +++ b/drivers/video/fbdev/matrox/matroxfb_accel.c
>>> @@ -88,7 +88,7 @@
>>> =C2=A0 static inline void matrox_cfb4_pal(u_int32_t* pal) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int i;
>>> -
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < 16; i++) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pal[i] =3D i * =
0x11111111U;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> @@ -96,7 +96,7 @@ static inline void matrox_cfb4_pal(u_int32_t* pal) {
>>> =C2=A0 static inline void matrox_cfb8_pal(u_int32_t* pal) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int i;
>>> -
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < 16; i++) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pal[i] =3D i * =
0x01010101U;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> @@ -482,7 +482,7 @@ static void matroxfb_1bpp_imageblit(struct matrox_=
fb_info *minfo, u_int32_t fgx,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 /* Tell... well, why bother... */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 while (height--) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t i;
>>> -
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < step; i +=3D 4) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Hope that the=
re are at least three readable bytes beyond the end of bitmap */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fb_writel(get_un=
aligned((u_int32_t*)(chardata + i)),mmio.vaddr);
>>> diff --git a/drivers/video/fbdev/matrox/matroxfb_base.h b/drivers/vide=
o/fbdev/matrox/matroxfb_base.h
>>> index 958be6805f87..c93c69bbcd57 100644
>>> --- a/drivers/video/fbdev/matrox/matroxfb_base.h
>>> +++ b/drivers/video/fbdev/matrox/matroxfb_base.h
>>> @@ -301,9 +301,9 @@ struct matrox_altout {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (*verifymode)(void* altout_dev, u_int32_t mode);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (*getqueryctrl)(void* altout_dev,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct v4l2_quer=
yctrl* ctrl);
>>
>> Noticed that there are plenty of coding style problems in matroxfb_base=
.h,
>>
>> why you only fix a few of them?=C2=A0=C2=A0 Take this two line as an ex=
ample, shouldn't
>>
>> they be fixed also as following?
>
> I configured my text editor to remove trailing whitespaces
> automatically. That keeps my own patches free of them.  But the
> editor removes all trailing whitespaces, including those that have
> been there before. If I encounter such a case, I split out the
> whitespace fix and submit it separately.
>
> But the work I do within fbdev is mostly for improving DRM.

Sure.

> For the
> other issues in this file, I don't think that matroxfb should even be
> around any longer. Fbdev has been deprecated for a long time. But a
> small number of drivers are still in use and we still need its
> framebuffer console. So someone should either put significant effort
> into maintaining fbdev, or it should be phased out. But neither is
> happening.

You're wrong.

You don't mention that for most older machines DRM isn't an acceptable
way to go due to it's limitations, e.g. it's low-speed due to missing
2D-acceleration for older cards and and it's incapability to change screen
resolution at runtime (just to name two of the bigger limitations here).
So, unless we somehow find a good way to move such drivers over to DRM
(with a set of minimal 2D acceleration), they are still important.

Actually, I just did test matroxfb and pm2fb successfully a few days back,=
 and
they worked. For some smaller issues I've prepared patches, which are on h=
old
due conflicts with your latest file-move-around- and whitespace-changes wh=
ich are partly
in drm-misc.
And I do have some upcoming additional patches for console support.

Helge
