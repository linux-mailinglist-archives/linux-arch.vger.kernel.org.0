Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADC9709A6A
	for <lists+linux-arch@lfdr.de>; Fri, 19 May 2023 16:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjESOuI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 May 2023 10:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjESOuH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 May 2023 10:50:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EF41A6;
        Fri, 19 May 2023 07:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1684507765; i=deller@gmx.de;
        bh=Pj1LG5Utwzy7oSUbGmPubC+BUUsniVXrDIxDTOEkeOI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=tSCZRXCEu4HR2Kz+W3QijBKl9VTLiHC2N49HMFK+w1Hpq7F3BeCUmSxaeverRIduK
         YvbL2Ymxs0+Kp5aDW7gqVB49juie7ExHaJUlFUs2v60jM15gQ9mF3aH93i9x42RO9w
         9TXAzSs37I291wPx/bn8A73o/OlsLsYSYYE85DjzxMVaEA6yxB3HCFa+shHTzK9pxS
         cPh+lmhPc3rkF4R1AOlxE6B/2vE5tYm+MxGhTMIvL78Q81QkBfWiGyuLYO4zWOaHMG
         7hMnRilqDEXHeNRHjRPli5KXdm75BbFjdPjnsy5XqmnG2eFTxlZUPrDjQdX+ZaePe4
         vJWTj7xRB3auQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.152.232]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBDj4-1prnPX0fpm-00ChEA; Fri, 19
 May 2023 16:49:25 +0200
Message-ID: <ade998d7-abd7-3514-a8d4-25c3ec71b171@gmx.de>
Date:   Fri, 19 May 2023 16:49:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 37/41] fbdev: atyfb: Remove unused clock determination
Content-Language: en-US
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
 <20230516110038.2413224-38-schnelle@linux.ibm.com>
 <ZGN2FKSBkMREujgR@intel.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <ZGN2FKSBkMREujgR@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:imFSKe5fuE/OhtLKAsIULRQNuTzYdH/PCC+1ZlOSr9/KeiGoYxz
 fYJzRc92qIRdL1vlEzKoSpyTFB2X9aetsOZCaYtRapiztiYKf/98SjySwc5QkoBZWZzWEkF
 q0qexuWtAyK2XftNY9AlO8p9mW8zcBnBT2sDv400OmcOY2R9U7KuLU2NI085SY0Z71BsqbC
 exRh04UzyoRal5s7TuQrw==
UI-OutboundReport: notjunk:1;M01:P0:F6hcsYgijK4=;LujMkLAJlcpsClyXQ5ix44Lyzv1
 pG/GAlVohiISVUdZUHbMVfGS1jS7GysZKXL0FMzoapBoGi2pXdgoFLOAyd1o2oQcbR8ek8qgb
 0Aade+CEV7000j7xt17IPxA89E7yJANid1SDclfwD0Vu+2pQCW1COH1OQr5JgHajjwY9u+cvn
 hDxcqJHuJsDUBLG35UF8FcXwajiEv8alXQqRPU7J3TN2S2fGfGy56X6RpP1lXdwV29ftk/9LK
 m4MS5skf4XWXnY272t1Ug6nLndfivDAiPNlqrZ02hnbhLaLJFSi2uRbkIaaP6fjmS6FCj9WIO
 K+CCejY/g1os2LGVCrkGywZexGtloihZ/znNBovLll+IyFbbQX5PV4AoNvC9AXp2ELcEqZ3N3
 7Sl8mBkm6J4PEuJcggvbbcnCcL2Nt4658krAYzEFf7L6BS63+ygY4UZn1ZWXL4APN9s7lwpeD
 O8k02ZtSvS2SNSrZDT6zd/mXV4m5Fo1e1ndvOmOlwqWn47in6/a3s2buDlBWcYwmaP2Zx+0yj
 xjkh5d9MwfTWwIhn2KD3sX8I9MOb3raC012xJMMQxY6ecSIVKwr8cYorbQsNKtmiQp6HkIBp0
 RfCETpwmwnwtikLsnsIjbK91deGnT/9OqKnB+dkWtRVBtlvobqnev0x3fQWLgSFwaKWiMmhaM
 YPpuXwTig6zfYRgU6iZx1z2N566sx0hIFVkE8BRtMgIdlFSusxojz68tCpXe+UjkR6xCH9b1B
 5VXVVewjb4uniWy5nWm6Zrf9lJfRXCLlvPujACn6vB2XHRHQpQoIS2ZctTw1p/UIU7NoirNOS
 6/iapCj0rZfeR3ZxR1Hg8CshejQS9EqHSR0i98kWpM2K400vfe1TFKmZH9ozJfIEfJhxHZexg
 GzzL6a7L8Sa8kM/QlauRe3mfbOrCtB+o1HB4Yot8sOOROs0s4+YGExAiW5NPj/SbFk91nQLq0
 PBdmFaze2TUblHbilaOlhHirXv4=
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/16/23 14:24, Ville Syrj=C3=A4l=C3=A4 wrote:
> On Tue, May 16, 2023 at 01:00:33PM +0200, Niklas Schnelle wrote:
>> Just below the removed lines par->clk_wr_offset is hard coded to 3 so
>> there is no use in determining a different clock just to then ignore it
>> anyway. This also removes the only I/O port use remaining in the driver
>> allowing it to be built without CONFIG_HAS_IOPORT.
>>
>> Link: https://lore.kernel.org/all/ZBx5aLo5h546BzBt@intel.com/
>> Suggested-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>
> Reviewed-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
>
>> ---
>> Note: The HAS_IOPORT Kconfig option was added in v6.4-rc1 so
>>        per-subsystem patches may be applied independently

applied this patch to fbdev git tree.

Thanks!

Helge

>>
>>   drivers/video/fbdev/aty/atyfb_base.c | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev=
/aty/atyfb_base.c
>> index b02e4e645035..cba2b113b28b 100644
>> --- a/drivers/video/fbdev/aty/atyfb_base.c
>> +++ b/drivers/video/fbdev/aty/atyfb_base.c
>> @@ -3498,11 +3498,6 @@ static int atyfb_setup_generic(struct pci_dev *p=
dev, struct fb_info *info,
>>   	if (ret)
>>   		goto atyfb_setup_generic_fail;
>>   #endif
>> -	if (!(aty_ld_le32(CRTC_GEN_CNTL, par) & CRTC_EXT_DISP_EN))
>> -		par->clk_wr_offset =3D (inb(R_GENMO) & 0x0CU) >> 2;
>> -	else
>> -		par->clk_wr_offset =3D aty_ld_8(CLOCK_CNTL, par) & 0x03U;
>> -
>>   	/* according to ATI, we should use clock 3 for acelerated mode */
>>   	par->clk_wr_offset =3D 3;
>>
>> --
>> 2.39.2
>

