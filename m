Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5D52F36A5
	for <lists+linux-arch@lfdr.de>; Tue, 12 Jan 2021 18:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392510AbhALRHP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Jan 2021 12:07:15 -0500
Received: from sonic315-26.consmr.mail.ne1.yahoo.com ([66.163.190.152]:46714
        "EHLO sonic315-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392507AbhALRHP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 Jan 2021 12:07:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1610471188; bh=4wRdEm+vP4GuMx3if3DWgHHYx7cbJiQBI+RqS7HpXXY=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Nsrdky9f+R00Nk0gk2HXPyG93ctpZ4lBYndTFpB+YYZzMzMm23TOLKXfUmQbB4ffo2FK/sVR9m6cAzzANCwuQm5yPh855o4qsT9ke3SEX3b02qDNL9mwwxv1vrQYMCUL5ZvglXy2zOG68JkY0pSU8skM7dy7HVP0It97S3sYS82fsBK5fvBB8BaIvyLZMCpKs8DrMO5Xt+JhjpQ1EjJHHV4vq0NcHoInMaVt9gHX2e19DGMy9DV0gnMqrzxe5q/C42qvdxnnEzFWh7kHYRnITHQV9a/tyPxQyzScnzItt8BIy1Utxr3UGiWA+/53jQV/a9UtNqjenDh8bftv5oo0gw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1610471188; bh=KXbCPBql+oqg3TvjE5J2RR+ggdV9JUtU0TuzITKtdJs=; h=Subject:To:From:Date:From:Subject; b=QgSejH9rjaiOoNhnv47eqLYF78YaFLnUiFw91/tXgLvTgcRBe5jVunimtUl9WJW3T1jrXM1oN0Uk2uEYBUTOBDAKindNtL2bNKgjgBWH5K54rskEnHxvXTDeSIw7RGKDR+KrjmlHxiom9GV75nMGm58RU1eNAyeViekAhjVwkAuKaGZplw8AgTFSSDhnpo9ol6ODms1/dvGB0BC471DdJI+1q1Z33fVSh02scYgQV/PwnVTFy6vX9sujxhL9Gb6J9tgppZYRVofJXbaus55Xq6HF1J5vbOUyGlb63o2aZiDfnEirwR2sFjdqnFHLjXoYMc6kMp/GoNbxMAepdR6+Ag==
X-YMail-OSG: Grr4NF0VM1nlxFvex_erjvmKWNSyhZ.xEQBQb7fBRF903B.TsFkXF3HD2zyFIeR
 Nkpf1xSXmmrCwHWuVzF1ZAdSPKVk4m963_CNungskIZ49Lrb4MpDajFrduoKzRjk0Y75bhvDy5jQ
 QHSJBW1_8OflWz2PxL.Xt3M0ijT5czLyXteJ._8ojgBW8GG90zk_EIblG3rOrVfsemeHc4.x5oc8
 n8.qOAB0YN_wM2s2crEAYO1bcMK10m7y9e39K3uLMdwjvtDbLZCV0zsNmMLqJuM01k.h7ir_H.HF
 LjuvHkToYFwlyG4IPUjSRoPsm09M3l2xeum1v.0ieDYI97J8FU0Y3_SsAiVfdKXzqAcqTa45J7CC
 IjUrDyXYrWuzPpTeUaKVkicbcwLxWoi46En4VjzHl7lpKUNO_W6wJglxGNB_oTbwlITchaLMDHcG
 ah1cNbFTVd8allHzOyTJZPU4qkZ8ZZZ7bKucQWytueiyBlKfjuorHOa8KmOO1xu3gWRQajx0jgcy
 sdgnl1Lc6Q3z_97otin_k57Vn4vMruG5Yt5fA5kk.5wzRJFK7tLyGebey7EnOEIwQkC3zMQ7UJrB
 MZKDEOxekFD0NJ9ypTSi6VfFSdwf4gp3gDhsvjD5Gn.fxKqOQcRqmI_cTCp6gP0vL6AKyDO3aSzV
 UzDGrJ3JtZQ_gBRMzluSTqK8MZMUKj3i8J7L5GoRd7Hup0UGBqLOXI7__YNZQBneCmE92wexnoKf
 Eh4cH92FDPfy8SiMNutkzIkjBo8dP6F0Fs1JiQU4LPohueFLgOlLQdAhCliSZdX21OhyCMHahas.
 VojDU34Pj5Z5aPBXCBMrAm7A5Cf.h4KrNyNOQSuDbseW9yUuzwKEgxJExxeEtlvxkpA3paHEhSYc
 0rtoxRGa28v2JH3TG2VrAbSkCgxulZxuhdqyEugU1ZXAjF_p7BgRsS_2c2IkeCIms2tc0sKUx4ZC
 0WPwBkICaaKM1a4t.13WXpKwFxfpgvUAPZchHKScniHwruJoMdMK8IGkLao_brU3sD6YsDC5GXoC
 10NolcFol47g_HaAExsxNW5DbepoydbvfIH0TG.p_JEmfIw0lAsvQzZPcCXe2kLuHoc8Nf2sG0.K
 4_2fteD4_I4uCXIVvBG71U5sbxHjhVfaFMicOwsawovx9ijkLqjQVE6CvmK7ZtWjISM9woInI2Oc
 CaFiIfoxEi0Jw5GD2.fKPH5GwFTjQdCEjcXTptCCVJE2R9SIrfdOjtJRZ.OOC2agVw5MntLvQUmu
 qDJuchS5Gy0eWQEYSEK9Guifi0T4CtKDqORWqWsEZ4yYJG_RxuSDBpn1dvyfknf_6QLMINsUigtR
 jszUDzxb8P6.Xbe1vbDoYo..WzY8At6uQ12EzZstctqVtaedMEjgU52zkUO1xUd4sDVMXVdQDU7D
 M__6S6kuEn_MKlMMiyqD_mjPJTfmvn4UdwvfPjDOfb3XXXBqMZXBTSOLbnoie4WkT_e5TEyYYmA9
 HxD8Z0MqdH.mmHMuy9hHZoOl3joh_YMIth2AXEXAjJvVhaMuvjPVpoSTk3ML5yb5vkT4d1Hdq3EE
 O9EuKATjwRERN1H_EaEUrNYDIjcUo2ME.sLMgWTHbVZlXWoiKoRgTqB7oUyufdrpBfahK0VoJt3d
 OMG_tR.S882zbJw01riT_9nIwnZpIURYNgGLDk_XZQiUAP33WbSonqyAs2fnGPYjUQKw0BbzUchF
 DIT9et0.JquCTuFs7svQ_xYt19JDIvKdMnD6hJa196V54N8F.D5J.U85h8STQQXMlZI8bssXNoGN
 9dSz9MNZh4zHO6OJBTAS5af0LPycICNl1rx5Qm4ES6q4RKhqf0SrOwXbDTYUJxn36FwhGhXP5Dn9
 QZxknYtHQJ6YJV6dHcMMBiFVaeb869qHA2dE7KlvtVfzebcdPPS.Eg9Fg.LdvMYZ8unA2kG3wu7t
 JcpL.DqxbSpvqu5Qwvmls37lYXFxOJMC05Z8Xr0RFbWCN_ZOrEOy4Hd1T_3.fd3nBU.PXR3oFw7s
 Gjb1iWBMu46MPacekkpIclktBCHdlgX3ZyivsJBzg8jKNKoLzOqag8DDPUI59KpV4mbfRmEZGDQ0
 TlzUjS1HT4Hw9b5IcQ2z8ZnNbubvKRkJhnuuBaeTLhUZWRsoQjwisNyUwl3rPHtlwpWU.gco5bv1
 cnNJfH46yvS_mtSpHikjBKjyLc_2aPJdDRB1WDr4V1AM1mdvo0frilzoyIXATt72iStuDxC.8yXo
 moJvabaATQekQMkNJcXdzc33sXxEUlQRsNVmPSDTIdr1CCKwtDTNHf_I6Fdd8D5ujFabOZZKj_Uq
 MaWNb0Lh8n9DlNDZMPXISyE6EXsbxfQ37RW8b6RQp7qvF4n78Z_cQCcHVrKkbF.DsfIMsz7_lmm1
 q.Gt6saEa9ReNacY2T_lzM00m7Z5XSQYlRk8GI2mocPRa2_Ba_2C_MIMghrEc8StioBSwrPPQmZs
 l_WOSq78NN5SZeleGWvFG9auBUgrPqfViG4DWMf2yVmMa2vL2ERsn9TtV5.KW1lm_xuzm4eR3Sx2
 xX0ldZwy8t3cVWA6z11085qpCasVgrjN7gQunYrFrV1D64_Wc_sngKAzTsA6c2948LyMAID1SGy2
 xoRxdIGIZuuU_xm0sQvhRdanrPxy1Gou8Bjd89GxX2FBFtGqeu0dCaFzjtx_d1.8TLpa3AzwoUb5
 yn2dCXiPJBNugjcixbSIbMglOxqneDUaYy7e.WIbnBQwsFfAe24fz0lIWbhhVQZy9M73TuKspHg.
 LrkZM__GndO6VAg4HFhgT6Dalbvi2jK0TCpH9SQv9BJshzGuoL4V0z1.h6TzrDyFPwLAddAIRsnO
 gVPqFfhlVhshVxJ3oRMSFsA0HWpX3.tCFghtXMSfjMQC1HiOGffusjOTjJIqXwm0UoQQQDqDpHO9
 GRwdvGv9E1ZGLXIb_zQj2LCL7sMA1mDovb2rUNkMlCAGyLf_bo9ZavSDwiiwiZOsWY.gMW3wk2o.
 GBDoRev9z5qY6H1rFvC.YseAUJxC4ZdTDtNMMYvdXzeZQiyddQqiad7m2Ll4.U8TyMa9eQ.LlG3Q
 IJ4ts09eZQCiICinSsdguUCPgH7D8KLtq1gnLULcyUPhMpaawP0QhN7EdmMNhiAoKCEhTudDYe9n
 3LnYIYnqSVvFHOXG1_XCREyjq6BJ_UQt1X8pFHjvwglSkpfa8xPgYszssVHeGTxl8CSUYPA0g.m4
 s4oYbtYFMh_1oGDNGibw9Ugx.0DVnHXw_uHuvTCuaNaKfKF6abBoh8JlPd6QvcBSUo5PPD8fMjmH
 uqDERsyeXYw7rjkN9E7jHmKp2wanDsI03DqxI.7D003tmEH.H1TpL4tfuJZiORZzykJHJv.gw8sQ
 PFNRyVDOpQgeRSzgOEV7KxKperu1_P_Ds0BWjn87jAsOqrXtfjR2IOm4ET3Qc4cdO.I.Vy6Luft1
 WMDtkVG6KtCgu7Iizw0w3UsxQ67.MHxwCcnhBlW06xl0Qi0D4Iv.2rNZMHs5eK_1jIyBG.70pVtP
 NUEVz1u5pdi6G5bjJ9bE2Tdld001K3EL7zD4l
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Tue, 12 Jan 2021 17:06:28 +0000
Received: by smtp405.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 89f7a1b75bcc5a74b364c40da27ba0fe;
          Tue, 12 Jan 2021 17:06:24 +0000 (UTC)
Subject: Re: [RFC PATCH v2] selinux: security: Move selinux_state to a
 separate page
To:     pnagar@codeaurora.org
Cc:     arnd@arndb.de, jmorris@namei.org, serge@hallyn.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-arch@vger.kernel.org,
        psodagud@codeaurora.org, nmardana@codeaurora.org,
        dsule@codeaurora.org, Joe Perches <joe@perches.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <1610099389-28329-1-git-send-email-pnagar@codeaurora.org>
 <0f467390-e018-6051-0014-ab475ed76863@schaufler-ca.com>
 <dab6357acbd63edd53099d106d111bf4@codeaurora.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <e6bd9820-8b77-57fc-f318-9b928e4d951b@schaufler-ca.com>
Date:   Tue, 12 Jan 2021 09:06:23 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <dab6357acbd63edd53099d106d111bf4@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.17501 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.8)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/12/2021 1:36 AM, pnagar@codeaurora.org wrote:
> On 2021-01-08 22:41, Casey Schaufler wrote:
>> On 1/8/2021 1:49 AM, Preeti Nagar wrote:
>>> The changes introduce a new security feature, RunTime Integrity Check=

>>> (RTIC), designed to protect Linux Kernel at runtime. The motivation
>>> behind these changes is:
>>> 1. The system protection offered by SE for Android relies on the
>>> assumption of kernel integrity. If the kernel itself is compromised (=
by
>>> a perhaps as yet unknown future vulnerability), SE for Android securi=
ty
>>> mechanisms could potentially be disabled and rendered ineffective.
>>> 2. Qualcomm Snapdragon devices use Secure Boot, which adds cryptograp=
hic
>>> checks to each stage of the boot-up process, to assert the authentici=
ty
>>> of all secure software images that the device executes.=C2=A0 However=
, due to
>>> various vulnerabilities in SW modules, the integrity of the system ca=
n be
>>> compromised at any time after device boot-up, leading to un-authorize=
d
>>> SW executing.
>>
>> It would be helpful if you characterized the "various vulnerabilities"=

>> rather than simply asserting their existence. This would allow the rev=
iewer
>> to determine if the proposed patch addresses the issue.
>>
> There might not currently be vulnerabilities, but the system is meant m=
ore
> specifically to harden valuable assets against future compromises. The =
key
> value add is a third party independent entity keeping a watch on crucia=
l
> kernel assets.

Could you characterize the potential vulnerabilities, then?
Seriously, there's a gazillion ways data integrity can be
compromised. Which of those are addressed?

>
>>>
>>> The feature's idea is to move some sensitive kernel structures to a
>>> separate page and monitor further any unauthorized changes to these,
>>> from higher Exception Levels using stage 2 MMU. Moving these to a
>>> different page will help avoid getting page faults from un-related da=
ta.
>>
>> I've always been a little slow when it comes to understanding the
>> details of advanced memory management facilities. That's part of
>> why I work in access control. Could you expand this a bit, so that
>> someone who doesn't already know how your stage 2 MMU works might
>> be able to evaluate what you're doing here.
>>
> Sure, will include more details. The mechanism we have been working on
> removes the write permissions for HLOS in the stage 2 page tables for
> the regions to be monitored, such that any modification attempts to the=
se
> will lead to faults being generated and handled by handlers. If the
> protected assets are moved to a separate page, faults will be generated=

> corresponding to change attempts to these assets only. If not moved to =
a
> separate page, write attempts to un-related data which is present on th=
e
> monitored pages will also be generated.

Thanks.

>
>>> Using this mechanism, some sensitive variables of the kernel which ar=
e
>>> initialized after init or are updated rarely can also be protected fr=
om
>>> simple overwrites and attacks trying to modify these.
>>
>> How would this interact with or complement __read_mostly?
>>
> Currently, the mechanism we are working on developing is
> independent of __read_mostly. This is something we can look more into
> while working further on the mechanism.

Please either integrate the two or explain how they differ.
It appears that you haven't considered how you might exploit
or expand the existing mechanism.

>
>>>
>>> Currently, the change moves selinux_state structure to a separate pag=
e. In
>>> future we plan to move more security-related kernel assets to this pa=
ge to
>>> enhance protection.
>>
>> What's special about selinux_state? What about the SELinux policy?
>> How would I, as maintainer of the Smack security module, know if
>> some Smack data should be treated the same way?
>>
> We are investigating more of the SELinux related and other kernel asset=
s
> which can be included in the protection. The basis of selinux_state is
> because disabling of SELinux is one of the common attack vectors in
> Android. We understand any kernel assets, unauthorized changes to which=

> can give way to security or any other type of attack can be considered =
to
> be a potential asset to be added to the protection.

Yeah, I get that. It looks like this could be a useful mechanism
beyond SELinux. No point in hoarding it.

>
>>>
>>> We want to seek your suggestions and comments on the idea and the cha=
nges
>>> in the patch.
>>>
>>> Signed-off-by: Preeti Nagar <pnagar@codeaurora.org>
>>> ---
>>> =C2=A0include/asm-generic/vmlinux.lds.h | 10 ++++++++++
>>> =C2=A0include/linux/init.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++++
>>> =C2=A0security/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 ++++++++++
>>> =C2=A0security/selinux/hooks.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 4 ++++
>>> =C2=A04 files changed, 28 insertions(+)
>>>
>>> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/=
vmlinux.lds.h
>>> index b2b3d81..158dbc2 100644
>>> --- a/include/asm-generic/vmlinux.lds.h
>>> +++ b/include/asm-generic/vmlinux.lds.h
>>> @@ -770,6 +770,15 @@
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *(.scommon)=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> +#ifdef CONFIG_SECURITY_RTIC
>>> +#define RTIC_BSS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>>> +=C2=A0=C2=A0=C2=A0 . =3D ALIGN(PAGE_SIZE);=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>>> +=C2=A0=C2=A0=C2=A0 KEEP(*(.bss.rtic))=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>>> +=C2=A0=C2=A0=C2=A0 . =3D ALIGN(PAGE_SIZE);
>>> +#else
>>> +#define RTIC_BSS
>>> +#endif
>>> +
>>> =C2=A0/*
>>> =C2=A0 * Allow archectures to redefine BSS_FIRST_SECTIONS to add extr=
a
>>> =C2=A0 * sections to the front of bss.
>>> @@ -782,6 +791,7 @@
>>> =C2=A0=C2=A0=C2=A0=C2=A0 . =3D ALIGN(bss_align);=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>>> =C2=A0=C2=A0=C2=A0=C2=A0 .bss : AT(ADDR(.bss) - LOAD_OFFSET) {=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BSS_FIRST_SECTIONS=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RTIC_BSS=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 . =3D ALIGN(PAGE_SIZ=
E);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *(.bss..page_aligned=
)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 . =3D ALIGN(PAGE_SIZ=
E);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>>> diff --git a/include/linux/init.h b/include/linux/init.h
>>> index 7b53cb3..617adcf 100644
>>> --- a/include/linux/init.h
>>> +++ b/include/linux/init.h
>>> @@ -300,6 +300,10 @@ void __init parse_early_options(char *cmdline);
>>> =C2=A0/* Data marked not to be saved by software suspend */
>>> =C2=A0#define __nosavedata __section(".data..nosave")
>>>
>>> +#ifdef CONFIG_SECURITY_RTIC
>>> +#define __rticdata=C2=A0 __section(".bss.rtic")
>>> +#endif
>>> +
>>> =C2=A0#ifdef MODULE
>>> =C2=A0#define __exit_p(x) x
>>> =C2=A0#else
>>> diff --git a/security/Kconfig b/security/Kconfig
>>> index 7561f6f..66b61b9 100644
>>> --- a/security/Kconfig
>>> +++ b/security/Kconfig
>>> @@ -291,5 +291,15 @@ config LSM
>>>
>>> =C2=A0source "security/Kconfig.hardening"
>>>
>>> +config SECURITY_RTIC
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "RunTime Integrity C=
heck feature"
>>
>> Shouldn't this depend on the architecture(s) supporting the
>> feature?
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RTIC(RunTime Integrity Check) feature=
 is to protect Linux kernel
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 at runtime. This relocates some of th=
e security sensitive kernel
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 structures to a separate page aligned=
 special section.
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This is to enable monitoring and prot=
ection of these kernel assets
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from a higher exception level(EL) aga=
inst any unauthorized changes.
>>
>> "if you are unsure ..."
>>
> We just thought keeping it generic might be a better idea, thus, moved =
the
> changes to generic files from arch-specific files and thus, kept config=
 also
> independent of the arch. Can surely make this config arch dependent if =
that is
> a better approach?

It's kind of silly to enable this if the hardware doesn't
support it, isn't it?

>
>>> +
>>> =C2=A0endmenu
>>>
>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>> index 6b1826f..7add17c 100644
>>> --- a/security/selinux/hooks.c
>>> +++ b/security/selinux/hooks.c
>>> @@ -104,7 +104,11 @@
>>> =C2=A0#include "audit.h"
>>> =C2=A0#include "avc_ss.h"
>>>
>>> +#ifdef CONFIG_SECURITY_RTIC
>>> +struct selinux_state selinux_state __rticdata;
>>> +#else
>>> =C2=A0struct selinux_state selinux_state;
>>> +#endif
>>
>> Shouldn't the __rticdata tag be applied always, and its
>> definition take care of the cases where it doesn't do anything?
>>
> Will update this change in the next version of the patch. Thank you.

I saw that several other people had the same comment.

>
>>>
>>> =C2=A0/* SECMARK reference count */
>>> =C2=A0static atomic_t selinux_secmark_refcount =3D ATOMIC_INIT(0);

